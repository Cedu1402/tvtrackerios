//
//  ShowService.swift
//  TvTracker
//
//  Created by cedric blaser on 21.11.20.
//

import Foundation
import Alamofire

class ShowService {

    func getReleases(pageNr: Int, completion: @escaping ([ShowModel]) -> ()) {
        
        
        guard let traktUrl = URL(string: TraktApi.baseUrl + "shows/trending?extended=full&page=\(pageNr)") else {return }
        
        var urlRequest = URLRequest(url: traktUrl)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("2", forHTTPHeaderField: "trakt-api-version")
        urlRequest.setValue(TraktApi.key, forHTTPHeaderField: "trakt-api-key")
        
        URLSession.shared.dataTask(with: urlRequest) { (response, _, _) in
            let result = try! JSONDecoder().decode([ShowApiModel].self, from: response!)
            var shows = [ShowModel]()
            
            for data in result{
                shows.append(ShowModel(id: UUID(),
                                       title: data.show.title,
                                       overview: data.show.overview,
                                       trakt: data.show.ids.trakt,
                                       imdb: data.show.ids.imdb,
                                       tvdb: data.show.ids.tvdb,
                                       imageURL: URL(string: "https://www.thetvdb.com/banners/posters/\(data.show.ids.tvdb)-1.jpg")!))
            }

            DispatchQueue.main.async{
                completion(shows)
            }
        }
        .resume()
    }
    
    func getImageUrl(completion: @escaping ([ShowApiModel]) -> ()) {
        guard let url = URL(string: "Test.ch") else {return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let urls = try! JSONDecoder().decode([ShowApiModel].self, from: data!)
            
            DispatchQueue.main.async{
                completion(urls)
            }
        }
        .resume()
        
    }
}
