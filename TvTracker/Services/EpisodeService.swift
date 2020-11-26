//
//  EpisodeService.swift
//  TvTracker
//
//  Created by cedric blaser on 26.11.20.
//

import Foundation

class EpisodeService {

    func getEpisodes(imdb: String, season: Int, completion: @escaping ([EpisodeModel]) -> ()) {
        
        guard let urlRequest = TraktApi.createTraktRequest(url: "shows/" + imdb + "/seasons/" + String(season) + "?extended=full") else {
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (response, _, _) in
            var episodes = [EpisodeModel]()
            if(response == nil){
                return
            }
            
            do {
                let result = try JSONDecoder().decode([EpisodeApiModel].self, from: response!)
                for data in result {
                    episodes.append(EpisodeModel(season: data.season,
                                                 number: data.number,
                                                 title: data.title,
                                                 overview: data.overview,
                                                 firstAired: TraktApi.convertToDate(date: data.first_aired),
                                                 runtime: data.runtime,
                                                 trakt: data.ids.trakt,
                                                 imdb: data.ids.imdb,
                                                 tvdb: data.ids.tvdb))
                }
            }catch{
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
            DispatchQueue.main.async{
                completion(episodes)
            }
        }
        .resume()
    }
    
}


