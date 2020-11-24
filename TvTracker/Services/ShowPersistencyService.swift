//
//  ShowPersistencyService.swift
//  TvTracker
//
//  Created by cedric blaser on 24.11.20.
//

import Foundation
import CoreData

class ShowPersistencyService {
    
    let persistenceController = PersistenceController.shared
    
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
        newFavoriteShow.title = show.title
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
