//
//  ShowService.swift
//  TvTracker
//
//  Created by cedric blaser on 21.11.20.
//

import Foundation
import CoreData

class ShowService {
    
    private let showPersitencyService = ShowPersistencyService(persistency: PersistenceController.shared)
    
    func getReleases(pageNr: Int, completion: @escaping ([ShowModel]) -> ()) {
        
        guard let urlRequest = TraktApi.createTraktRequest(url: "shows/trending?extended=full&page=\(pageNr)") else {
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (response, _, _) in
            var shows = [ShowModel]()
            if(response == nil){
                return
            }
            
            do {
                let result = try JSONDecoder().decode([ShowApiModel].self, from: response!)
                for (index, data) in result.enumerated() {
                    shows.append(ShowModel(id: UUID(),
                                           index: index + (pageNr - 1) * 10,
                                           title: data.show.title,
                                           overview: data.show.overview,
                                           trakt: data.show.ids.trakt,
                                           imdb: data.show.ids.imdb,
                                           tvdb: data.show.ids.tvdb,
                                           imageURL: URL(string: "https://www.thetvdb.com/banners/posters/\(data.show.ids.tvdb)-1.jpg")!,
                                           favorite: self.showPersitencyService.isFavorite(data: data)))
                }
            }catch{
            
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
