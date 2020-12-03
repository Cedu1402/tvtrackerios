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
    
    init(favoriteView: Bool, show: ShowModel, season: Int){
        self.favoriteView = favoriteView
        self.show = show
        self.season = season
    }
    
    public func loadContent(){
        
        if favoriteView {
           // loadContentCoreData(show: show)
        }else {
            loadContentTrakt(show: self.show, season: self.season)
        }
    }
    
    private func loadContentTrakt(show: ShowModel, season: Int){
        if (self.isLoadingPage || self.episodes.count > 0) {
            return
        }

        self.isLoadingPage = true

        self.episodeService.getEpisodes(show: show, season: season, completion: { (data) in
            self.episodes.append(contentsOf: data)
            self.isLoadingPage = false
        })
        
    }
    
}





