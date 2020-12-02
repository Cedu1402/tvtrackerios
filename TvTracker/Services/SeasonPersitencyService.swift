//
//  SeasonPersitencyService.swift
//  TvTracker
//
//  Created by cedric blaser on 26.11.20.
//

import Foundation
import CoreData

class SeasonPersistencyService {
    
    private let context: NSManagedObjectContext
    private let seasonService: SeasonServiceProtocol
    
    init(persistency: PersistenceController, seasonService: SeasonServiceProtocol) {
        context = persistency.container.viewContext
        self.seasonService = seasonService
    }
    
    
    public func saveSeasonOfShow(show: Show){
        self.seasonService.getSeasons(show: ShowModel.convertFromShow(show: show, index: 0)) { (seasons) in
            
            for season in seasons {
                let newSeason = NSEntityDescription.insertNewObject(
                    forEntityName: "Season", into: self.context) as! Season
                
                newSeason.overview = season.overview
                newSeason.title = season.title
                newSeason.episodeCount = Int64(season.episodeCount)
                newSeason.firstAired = season.firstAired
                newSeason.airedEpisodes = Int64(season.airedEpisodes)
                newSeason.tvdb = Int64(season.tvdb)
                newSeason.trakt = Int64(season.trakt)
                newSeason.number = Int64(season.number)
                newSeason.imageUrl = FileService.saveImageToFileSystem(image: season.imageUrl)
                show.addToSeasons(newSeason)
            }
            
            // only save once per batch insert
            do {
                try self.context.save()
            } catch {
                print(error)
            }
        }
    }
    
}
