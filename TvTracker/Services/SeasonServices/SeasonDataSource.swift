//
//  ReleaseDataSource.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 30.11.20.
//

import Foundation

class SeasonDataSource: ObservableObject {
    
    @Published var seasons = [SeasonModel]()
    @Published var isLoadingPage = false
    
    private let seasonService = SeasonService()
    private let seasonPersistencyService = SeasonPersistencyService(
        persistency: PersistenceController.shared,
        seasonService: SeasonService())
    private let showPersistencyService = ShowPersistencyService(persistency: PersistenceController.shared)
    private var canLoadMorePages = true
    
    private let favoriteView: Bool
    private let show: ShowModel
    
    init(favoriteView: Bool, show: ShowModel){
        self.favoriteView = favoriteView
        self.show = show
    }
    
    public func loadContent(){
        if self.favoriteView {
            loadContentCoreData(show: self.show)
        }else {
            loadContentTrakt(show: self.show)
        }
    }
    
    private func loadContentTrakt(show: ShowModel){
        if (isLoadingPage || self.seasons.count > 0 || !canLoadMorePages) {
            return
        }

        isLoadingPage = true

        self.seasonService.getSeasons(show: show) { (data) in
            self.seasons.append(contentsOf: data)
            
            self.isLoadingPage = false
            self.canLoadMorePages = false
        }
    }
    
    
    private func loadContentCoreData(show: ShowModel) {
        if (isLoadingPage || self.seasons.count > 0 || !self.canLoadMorePages) {
            return
        }
        
        isLoadingPage = true
        
        guard let favoriteSeasons = self.showPersistencyService.getSeasonsOfShow(imdb: show.imdb) else {
            return
        }
        
        for favorite in favoriteSeasons {
            self.seasons.append(SeasonModel(id: UUID(),
                                            title: favorite.title ?? "",
                                            overview: favorite.overview ?? "",
                                            episodeCount: Int(favorite.episodeCount),
                                            airedEpisodes: Int(favorite.airedEpisodes),
                                            firstAired: favorite.firstAired ?? Date(),
                                            number: Int(favorite.number),
                                            trakt: Int(favorite.trakt),
                                            tvdb: Int(favorite.tvdb),
                                            tmdb: Int(favorite.tmdb),
                                            imageUrl: favorite.imageUrl ?? URL(string: "")!))
        }
        
        self.seasons.sort {
            $0.number < $1.number
        }
        isLoadingPage = false
        self.canLoadMorePages = false
    }
    
}
