//
//  EpisodeService.swift
//  TvTracker
//
//  Created by cedric blaser on 26.11.20.
//

import Foundation

class EpisodeService {

    func getEpisodes(imdb: String, season: Int, completion: @escaping ([EpisodeModel]) -> ()) {
        guard let traktUrl = URL(string: TraktApi.baseUrl + "shows/" + imdb + "/seasons/" + String(season) + "?extended=full") else {return }
        
        var urlRequest = URLRequest(url: traktUrl)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("2", forHTTPHeaderField: "trakt-api-version")
        urlRequest.setValue(TraktApi.key, forHTTPHeaderField: "trakt-api-key")
        
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
                                                 firstAired: data.first_aired,
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


