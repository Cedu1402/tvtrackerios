//
//  ShowService.swift
//  TvTracker
//
//  Created by cedric blaser on 21.11.20.
//

import Foundation
import CoreData

class ShowService {
    
    // core data context.
    let persistenceController = PersistenceController.shared
    
    func getReleases(pageNr: Int, completion: @escaping ([ShowModel]) -> ()) {
        
        
        guard let traktUrl = URL(string: TraktApi.baseUrl + "shows/trending?extended=full&page=\(pageNr)") else {return }
        
        var urlRequest = URLRequest(url: traktUrl)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("2", forHTTPHeaderField: "trakt-api-version")
        urlRequest.setValue(TraktApi.key, forHTTPHeaderField: "trakt-api-key")
        
        URLSession.shared.dataTask(with: urlRequest) { (response, _, _) in
            let result = try! JSONDecoder().decode([ShowApiModel].self, from: response!)
            var shows = [ShowModel]()
            
            for (index, data) in result.enumerated() {
                shows.append(ShowModel(id: UUID(),
                                       index: index + (pageNr - 1) * 10,
                                       title: data.show.title,
                                       overview: data.show.overview,
                                       trakt: data.show.ids.trakt,
                                       imdb: data.show.ids.imdb,
                                       tvdb: data.show.ids.tvdb,
                                       imageURL: URL(string: "https://www.thetvdb.com/banners/posters/\(data.show.ids.tvdb)-1.jpg")!,
                                       favorite: self.isFavorite(data: data)))
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
    
    
    func isFavorite(data: ShowApiModel) -> Bool {
        let query: NSFetchRequest<Show> = Show.fetchRequest()
        let filter = NSPredicate(format: "trakt == %d", data.show.ids.trakt)
        let sort = NSSortDescriptor(key: "trakt", ascending: true)
        query.predicate = filter
        query.sortDescriptors = [sort]
        
        do{
            let result = try self.persistenceController.container.viewContext.count(for: query)
            return result > 0
        }catch{
            return false
        }
    }
    
    func saveAsFavorite(show: ShowModel){
        let managedObjectContext = self.persistenceController.container.viewContext
        let newFavoriteShow = Show(context: managedObjectContext)
        newFavoriteShow.titel = show.title
        newFavoriteShow.overview = show.overview
        newFavoriteShow.imdb = show.imdb
        newFavoriteShow.tvdb = Int64(show.tvdb)
        newFavoriteShow.trakt = Int64(show.trakt)
        newFavoriteShow.imageURL = show.imageURL
        try? managedObjectContext.save()
    }
    
    
    func removeFavorite(show: ShowModel){
        let managedObjectContext = self.persistenceController.container.viewContext
        let fetchRequest: NSFetchRequest<Show> = Show.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trakt == %d", show.trakt)
        fetchRequest.sortDescriptors =  [NSSortDescriptor(key: "trakt", ascending: true)]
        
        do {
            let objects = try managedObjectContext.fetch(fetchRequest)
            for object in objects {
                managedObjectContext.delete(object)
            }
            try managedObjectContext.save()
        } catch {
            return
        }
    }
}
