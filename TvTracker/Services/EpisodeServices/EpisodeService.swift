//
//  EpisodeService.swift
//  TvTracker
//
//  Created by cedric blaser on 26.11.20.
//

import Foundation
import Alamofire

class EpisodeService {

    func getEpisodes(show: ShowModel, season: Int, completion: @escaping ([EpisodeModel]) -> ()) {
        
        AF.request(URL(string: TraktApi.baseUrl + "shows/" + show.imdb + "/seasons/" + String(season) + "?extended=full")!,
                   headers: TraktApi.getHeaders()).responseData { response in
                    
            var episodes = [EpisodeModel]()
            if(response.data == nil){
                return
            }
            
            do {
                let result = try JSONDecoder().decode([EpisodeApiModel].self, from: response.data!)
                for data in result {
                    episodes.append(EpisodeModel(id: UUID(),
                                                 season: data.season,
                                                 number: data.number,
                                                 title: data.title,
                                                 overview: data.overview,
                                                 firstAired: TraktApi.convertToDate(date: data.first_aired),
                                                 runtime: data.runtime,
                                                 trakt: data.ids.trakt,
                                                 imdb: data.ids.imdb,
                                                 tvdb: data.ids.tvdb,
                                                 imageUrl: show.imageURL))
                }
            }catch{
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            }
                    
            self.getImagesOfEpisodes(show: show, season: season, episodes: episodes) { (data) in
                completion(data.sorted {
                    $0.number < $1.number
                })
            }
            
        }
    }

    func getImagesOfEpisodes(show: ShowModel,
                             season: Int,
                             episodes: [EpisodeModel],
                             completion: @escaping ([EpisodeModel]) -> ()) {
        
        var changed = [EpisodeModel]()
        let dispatchGroup = DispatchGroup()
        // change the quality of service based on your needs
        let queue = DispatchQueue(label: "tmdb.api.episode", qos: .userInteractive)
        
        for episode in episodes {
            dispatchGroup.enter()
            queue.async {
                self.getImageUrl(tmdb: show.tmdb, season: season, episode: episode.number) { url in
                    dispatchGroup.leave()
                    var updatedEpisode = episode
                    updatedEpisode.imageUrl = URL(string: url ?? show.imageURL.absoluteString) ?? show.imageURL
                    changed.append(updatedEpisode)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main, execute: {
            completion(changed)
        })
    }

    
    func getImageUrl(tmdb: Int, season: Int, episode: Int, completion: @escaping (String?) -> ()) {
       
        let url = "https://api.themoviedb.org/3/tv/\(tmdb)/season/\(season)/episode/\(episode)/images?api_key=\(TmdbApi.key)"
        let baseImageUrl = "http://image.tmdb.org/t/p/w500"
        
        AF.request(url).responseData { response in
            if(response.data == nil){
                completion(nil)
            }
            do {
                let result = try JSONDecoder().decode(TMDBEpisodeImages.self, from: response.data!)
                completion(result.stills.count > 0 ? baseImageUrl + result.stills[0].file_path : nil)
            }catch{
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
                completion(nil)
            }
        }
    }
    
}
