//
//  ShowPersistencyService.swift
//  TvTracker
//
//  Created by cedric blaser on 24.11.20.
//

import Foundation
import CoreData

class ShowPersistencyService {
    
    private let context: NSManagedObjectContext
    private let seasonPersistencyService: SeasonPersistencyService
    
    init(persistency: PersistenceController){
        context = persistency.container.viewContext
        seasonPersistencyService = SeasonPersistencyService(persistency: persistency,
                                                            seasonService: SeasonService())
    }

    func isFavorite(trakt: Int) -> Bool {
        let query: NSFetchRequest<Show> = Show.fetchRequest()
        let filter = NSPredicate(format: "trakt == %d", trakt)
        let sort = NSSortDescriptor(key: "trakt", ascending: true)
        query.predicate = filter
        query.sortDescriptors = [sort]
        
        do{
            let result = try self.context.count(for: query)
            return result > 0
        }catch{
            return false
        }
    }
    
    func getFavorites() -> [Show] {
        let query: NSFetchRequest<Show> = Show.fetchRequest()
        let sort = NSSortDescriptor(key: "title", ascending: true)
        query.sortDescriptors = [sort]
        
        do{
            return try self.context.fetch(query)
        }catch{
            return [Show]()
        }
    }
    
    func saveAsFavorite(show: ShowModel){
        let newFavoriteShow = Show(context: self.context)
        newFavoriteShow.title = show.title
        newFavoriteShow.overview = show.overview
        newFavoriteShow.imdb = show.imdb
        newFavoriteShow.tvdb = Int64(show.tvdb)
        newFavoriteShow.trakt = Int64(show.trakt)
        
        let localImage = FileService.saveImageToFileSystem(image: show.imageURL)
        newFavoriteShow.imageURL = localImage
        
        let localBanner = FileService.saveImageToFileSystem(image: show.bannerImageURL)
        newFavoriteShow.bannerImageURL = localBanner
        
        try? self.context.save()
        
        self.seasonPersistencyService.saveSeasonOfShow(show: newFavoriteShow)
    }
    
    
    func removeFavorite(show: ShowModel){
        let fetchRequest: NSFetchRequest<Show> = Show.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trakt == %d", show.trakt)
        fetchRequest.sortDescriptors =  [NSSortDescriptor(key: "trakt", ascending: true)]
        
        do {
            let objects = try self.context.fetch(fetchRequest)
            for object in objects {
                self.context.delete(object)
            }
            try self.context.save()
        } catch {
            return
        }
    }
    

    
    func serachShow(text: String) -> [Show] {
        let query: NSFetchRequest<Show> = Show.fetchRequest()
        let filter = NSPredicate(format: "title CONTAINS[c] %@", text)
        let sort = NSSortDescriptor(key: "title", ascending: true)
        query.predicate = filter
        query.sortDescriptors = [sort]

        do{
            return try self.context.fetch(query)
        }catch{
            return [Show]()
        }
    }
    
    public func getSeasonsOfShow(imdb: String) -> [Season]? {
        let query: NSFetchRequest<Show> = Show.fetchRequest()
        let filter = NSPredicate(format: "imdb == %@", imdb)
        let sort = NSSortDescriptor(key: "title", ascending: true)
        query.predicate = filter
        query.sortDescriptors = [sort]

        do{
            let result = try self.context.fetch(query)
            if result.count == 0 {
                return nil
            }
            guard let seasons = result[0].seasons else {
                return nil
            }
            
            return seasons.allObjects as? [Season]
        }catch{
            return nil
        }
        
    }
    
}
