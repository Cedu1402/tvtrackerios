//
//  SeasonService.swift
//  TvTracker
//
//  Created by cedric blaser on 24.11.20.
//

import Foundation
class SeasonService {
    
    
    
    func getSeasons(showId: Int, completion: @escaping ([SeasonModel]) -> ()) {
        guard let traktUrl = URL(string: TraktApi.baseUrl + "shows/" + String(showId) + "/seasons?extended=full") else {return }
        
        var urlRequest = URLRequest(url: traktUrl)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("2", forHTTPHeaderField: "trakt-api-version")
        urlRequest.setValue(TraktApi.key, forHTTPHeaderField: "trakt-api-key")
        
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


