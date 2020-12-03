//
//  EpisodePersistencyService.swift
//  TvTracker
//
//  Created by cedric blaser on 02.12.20.
//

import Foundation
import CoreData


class EpisodePersistencyService {
    
    private let context: NSManagedObjectContext
    private let episodeService = EpisodeService()
    
    init(persistency: PersistenceController) {
        context = persistency.container.viewContext
    }
    
    
    public func saveEpisodesOfSeason(show: ShowModel, season: Season){
        self.episodeService.getEpisodes(show: show, season: Int(season.number)) { (data) in
            for episode in data {
                let newEpisode = NSEntityDescription.insertNewObject(
                    forEntityName: "Episode", into: self.context) as! Episode
                
                newEpisode.title = episode.title
                newEpisode.overview = episode.overview
                newEpisode.firstAired = episode.firstAired
                newEpisode.imageUrl = episode.imageUrl
                newEpisode.imdb = episode.imdb
                newEpisode.trakt = Int64(episode.trakt)
                newEpisode.tvdb = Int64(episode.tvdb)
                newEpisode.trakt = Int64(episode.trakt)
                newEpisode.number = Int64(episode.number)
                season.addToEpisodes(newEpisode)
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
