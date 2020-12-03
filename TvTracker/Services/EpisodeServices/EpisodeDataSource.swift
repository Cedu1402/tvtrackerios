//
//  EpisodeDataSource.swift
//  TvTracker
//
//  Created by cedric blaser on 02.12.20.
//

import Foundation

class EpisodeDataSource: ObservableObject {
    @Published var episodes = [EpisodeModel]()
    @Published var isLoadingPage = false
    
    private let favoriteView: Bool
    private let episodeService = EpisodeService()
    private let show: ShowModel
    private let season: Int
    private let showPersistencyService = ShowPersistencyService(persistency: PersistenceController.shared)
    private var canLoadMorePages = true
    
    init(favoriteView: Bool, show: ShowModel, season: Int){
        self.favoriteView = favoriteView
        self.show = show
        self.season = season
    }
    
    public func loadContent(){
        if favoriteView {
           loadContentCoreData(show: show)
        }else {
            loadContentTrakt(show: self.show, season: self.season)
        }
    }
    
    private func loadContentTrakt(show: ShowModel, season: Int){
        if (self.isLoadingPage || self.episodes.count > 0 || !canLoadMorePages) {
            return
        }

        self.isLoadingPage = true
        
        self.episodeService.getEpisodes(show: show, season: season, completion: { (data) in
            self.episodes.append(contentsOf: data)
            self.isLoadingPage = false
            self.canLoadMorePages = false
        })
    }
    
    private func loadContentCoreData(show: ShowModel){
        if (self.isLoadingPage || self.episodes.count > 0 || !canLoadMorePages) {
            return
        }

        self.isLoadingPage = true
        guard let episodes = self.showPersistencyService.getEpisodesOfShowAndSeason(imdb: show.imdb, number: self.season) else {
            return
        }
        
        for episode in episodes {
            self.episodes.append(EpisodeModel(id: UUID(),
                                              season: self.season,
                                              number: Int(episode.number),
                                              title: episode.title ?? "",
                                              overview: episode.overview ?? "",
                                              firstAired: episode.firstAired ?? Date(),
                                              runtime: Int(episode.runtime),
                                              trakt: Int(episode.trakt),
                                              imdb: episode.imdb ?? "",
                                              tvdb: Int(episode.tvdb),
                                              imageUrl: episode.imageUrl ?? show.imageURL))
        }
        
        
        self.episodes.sort {
            $0.number < $1.number
        }
        isLoadingPage = false
        canLoadMorePages = false
    }
    
}





