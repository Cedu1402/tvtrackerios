//
//  ShowService.swift
//  TvTracker
//
//  Created by cedric blaser on 21.11.20.
//

import Foundation
import Alamofire

class ShowService {
    
    private let showPersitencyService = ShowPersistencyService(persistency: PersistenceController.shared)
    
    func getReleases(pageNr: Int, completion: @escaping ([ShowModel]) -> ()) {
        
        AF.request(TraktApi.baseUrl + "shows/trending?extended=full&page=\(pageNr)",
                   headers: TraktApi.getHeaders()).responseData { response in
            
            var shows = [ShowModel]()
            if(response.data == nil){
                return
            }
            
            do {
                let result = try JSONDecoder().decode([ShowApiModel].self, from: response.data!)
                for (index, data) in result.enumerated() {
                    shows.append(ShowModel(id: UUID(),
                                           index: index + (pageNr - 1) * 10,
                                           title: data.show.title,
                                           overview: data.show.overview ?? "",
                                           trakt: data.show.ids.trakt,
                                           imdb: data.show.ids.imdb ?? "",
                                           tvdb: data.show.ids.tvdb ?? 0,
                                           tmdb: data.show.ids.tmdb ?? 0,
                                           imageURL: URL(string: "https://www.thetvdb.com/banners/posters/\(data.show.ids.tvdb ?? 0)-1.jpg")!,
                                           bannerImageURL: URL(string: "https://www.thetvdb.com/banners/posters/\(data.show.ids.tvdb ?? 0)-1.jpg")!,
                                           favorite: self.showPersitencyService.isFavorite(trakt: data.show.ids.trakt)))
                }
                
                self.getImagesOfShow(queueName: String("release.images"), shows: shows) { showsWithImages in
                    completion(showsWithImages)
                }
            }catch{
                return
            }
        }
        
    }
    
    func getImagesOfShow(queueName: String,
                         shows: [ShowModel],
                         completion: @escaping ([ShowModel]) -> ()) {
        
        var changed = [ShowModel]()
        let dispatchGroup = DispatchGroup()
        // change the quality of service based on your needs
        let queue = DispatchQueue(label: queueName, qos: .userInteractive)
        
        for show in shows{
            dispatchGroup.enter()
            queue.async {
                self.getImageUrl(tmdb: show.tmdb) { url in
                    dispatchGroup.leave()
                    var updatedShow = show
                    updatedShow.imageURL = URL(string: url.image ?? show.imageURL.absoluteString) ?? show.imageURL
                    updatedShow.bannerImageURL = URL(string: url.banner ?? updatedShow.imageURL.absoluteString) ?? updatedShow.imageURL
                    changed.append(updatedShow)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main, execute: {
            completion(changed)
        })
    }
    
    func getImageUrl(tmdb: Int, completion: @escaping ((image: String?, banner: String?)) -> ()) {
        let key = "71924cf7c3c58c0d8576553cbb9f2132"
        let url = "https://api.themoviedb.org/3/tv/\(tmdb)/images?api_key=\(key)"
        let baseImageUrl = "http://image.tmdb.org/t/p/w500"
        
        AF.request(url).responseData { response in
            if(response.data == nil){
                completion((image: nil, banner: nil))
            }
            
            do {
                let result = try JSONDecoder().decode(TMDBImages.self, from: response.data!)
                let poster = result.posters.count > 0 ? baseImageUrl + result.posters[0].file_path : nil
                let banner = result.backdrops.count > 0 ? baseImageUrl + result.backdrops[0].file_path : nil
                completion((image: poster, banner: banner))
            }catch{
                print(error)
                completion((image: nil, banner: nil))
            }
        }
    }
    
    func searchShow(query: String, pageNr: Int, completion: @escaping ([ShowModel]) -> ()) {
        
        AF.request(TraktApi.baseUrl + "search/show", method: .get,
                   parameters: ["query": query,
                                "fields": "title",
                                "extended": "full",
                                "page": pageNr],
                   headers: TraktApi.getHeaders())
            .responseData { response in
            
            var shows = [ShowModel]()
            if(response.data == nil){
                return
            }
            
            do {
                let result = try JSONDecoder().decode([SearchModel].self, from: response.data!)
                for (index, data) in result.enumerated() {
                    shows.append(ShowModel(id: UUID(),
                                           index: index + (pageNr - 1) * 10,
                                           title: data.show.title,
                                           overview: data.show.overview ?? "",
                                           trakt: data.show.ids.trakt,
                                           imdb: data.show.ids.imdb ?? "",
                                           tvdb: data.show.ids.tvdb ?? 0,
                                           tmdb: data.show.ids.tmdb ?? 0,
                                           imageURL: URL(string: "https://www.thetvdb.com/banners/posters/\(data.show.ids.tvdb ?? 0)-1.jpg")!,
                                           bannerImageURL: URL(string: "https://www.thetvdb.com/banners/posters/\(data.show.ids.tvdb ?? 0)-1.jpg")!,
                                           favorite: self.showPersitencyService.isFavorite(trakt: data.show.ids.trakt)))
                }
                
                self.getImagesOfShow(queueName: String("search.images"), shows: shows) { showsWithImages in
                    completion(showsWithImages)
                }
                
            }catch{
                print(error)
                return
            }
        }
    }
    
}
