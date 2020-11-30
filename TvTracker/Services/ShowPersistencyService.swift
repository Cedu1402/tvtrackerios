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
    
    init(persistency: PersistenceController){
        context = persistency.container.viewContext
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
        let localImage = self.saveImageToFileSystem(image: show.imageURL)
        newFavoriteShow.imageURL = localImage
        try? self.context.save()
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
    
    func saveImageToFileSystem(image: URL) -> URL {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let name = image.deletingPathExtension().lastPathComponent + "." + image.pathExtension
        let fileURL = documentsUrl.appendingPathComponent(name)
        do {
            let data = try Data(contentsOf: image) // not NSData !!
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print(error,"failed to save image")
            return image
        }
        return fileURL
    }
    
}
