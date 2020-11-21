//
//  ShowService.swift
//  TvTracker
//
//  Created by cedric blaser on 21.11.20.
//

import Foundation
import Alamofire

class ShowService {

    func getReleases(success: @escaping(_ result: [ShowModel]) -> Void) -> Void {
        
        let realeseURL = TraktApi.baseUrl + "shows/trending?extended=full"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "trakt-api-version": "2",
            "trakt-api-key": TraktApi.key
        ]
        
        AF.request(realeseURL, headers: headers).responseData{ response in
            do {
                let result = try JSONDecoder().decode([ShowApiModel].self, from: response.data!)
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
                success(shows)
            }catch {
                print("Unexpected error: \(error).")
            }
        }
        
    }
}
