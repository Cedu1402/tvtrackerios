//
//  SeasonService.swift
//  TvTracker
//
//  Created by cedric blaser on 24.11.20.
//

import Foundation
import Alamofire

class SeasonService: SeasonServiceProtocol {

    func getSeasons(show: ShowModel, completion: @escaping ([SeasonModel]) -> ()) {
        
        AF.request(URL(string: TraktApi.baseUrl + "shows/" + show.imdb + "/seasons?extended=full")!).responseData { response in
            var seasons = [SeasonModel]()
            
            if(response.data == nil){
                return
            }
            
            do {
                let result = try JSONDecoder().decode([SeasonApiModel].self, from: response.data!)
                for data in result {
                    seasons.append(SeasonModel(id: UUID(),
                                               title: data.title,
                                               overview: data.overview,
                                               episodeCount: data.episode_count,
                                               airedEpisodes: data.aired_episodes,
                                               firstAired: TraktApi.convertToDate(date: data.first_aired),
                                               number: data.number,
                                               trakt: data.ids.trakt,
                                               tvdb: data.ids.tvdb,
                                               tmdb: data.ids.tmdb,
                                               imageUrl: show.bannerImageURL))
                }
            }catch{
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
            self.getImagesOfSeasons(show: show, seasons: seasons) { seasonsWithImages in
                completion(seasonsWithImages.sorted{
                    $0.number < $1.number
                })
            }
        }
        .resume()
    }
    
    func getImagesOfSeasons(show: ShowModel,
                            seasons: [SeasonModel],
                            completion: @escaping ([SeasonModel]) -> ()) {
        
        var changed = [SeasonModel]()
        let dispatchGroup = DispatchGroup()
        // change the quality of service based on your needs
        let queue = DispatchQueue(label: "tmdb.api", qos: .userInteractive)
        
        for season in seasons{
            dispatchGroup.enter()
            queue.async {
                self.getImageUrl(tmdb: show.tmdb, number: season.number) { url in
                    dispatchGroup.leave()
                    var updatedSeason = season
                    updatedSeason.imageUrl = URL(string: url ?? show.imageURL.absoluteString) ?? show.imageURL
                    changed.append(updatedSeason)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main, execute: {
            completion(changed)
        })
    }

    
    func getImageUrl(tmdb: Int, number: Int, completion: @escaping (String?) -> ()) {
       
        let url = "https://api.themoviedb.org/3/tv/\(tmdb)/season/\(number)/images?api_key=\(TmdbApi.key)"
        let baseImageUrl = "http://image.tmdb.org/t/p/w500"
        
        AF.request(url).responseData { response in
            if(response.data == nil){
                completion(nil)
            }
            do {
                let result = try JSONDecoder().decode(TMDBSeasonImages.self, from: response.data!)
                completion(result.posters.count > 0 ? baseImageUrl + result.posters[0].file_path : nil)
            }catch{
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
                completion(nil)
            }
        }
    }
}
