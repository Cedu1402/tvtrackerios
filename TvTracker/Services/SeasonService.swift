//
//  SeasonService.swift
//  TvTracker
//
//  Created by cedric blaser on 24.11.20.
//

import Foundation
class SeasonService {

    func getSeasons(imdb: String, completion: @escaping ([SeasonModel]) -> ()) {
        
        guard let urlRequest = TraktApi.createTraktRequest(url: "shows/" + imdb + "/seasons?extended=full") else {
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (response, _, _) in
            var seasons = [SeasonModel]()
            if(response == nil){
                return
            }
            
            do {
                let result = try JSONDecoder().decode([SeasonApiModel].self, from: response!)
                for data in result {
                    seasons.append(SeasonModel(id: UUID(),
                                               title: data.title,
                                               overview: data.overview,
                                               episodeCount: data.episode_count,
                                               airedEpisodes: data.aired_episodes,
                                               firstAired: data.first_aired,
                                               number: data.number,
                                               trakt: data.ids.trakt,
                                               tvdb: data.ids.tvdb,
                                               tmdb: data.ids.tmdb))
                }
            }catch{
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
            DispatchQueue.main.async{
                completion(seasons)
            }
        }
        .resume()
    }
    
}


