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
    private let seasonPersistencyService = SeasonPersistencyService(persistency: PersistenceController.shared,                                             seasonService: SeasonService())
    private let showPersistencyService = ShowPersistencyService(persistency: PersistenceController.shared)
    private let favoriteView: Bool
    
    init(favoriteView: Bool, show: ShowModel){
        self.favoriteView = favoriteView
        if favoriteView {
            loadContentCoreData(show: show)
        }else {
            loadContentTrakt(show: show)
        }
    }
    
    private func loadContentTrakt(show: ShowModel){
        if (isLoadingPage || self.seasons.count > 0) {
            return
        }

        isLoadingPage = true

        self.seasonService.getSeasons(show: show) { (data) in
            self.seasons.append(contentsOf: data)
            
            self.isLoadingPage = false
        }
    }
    
    
    private func loadContentCoreData(show: ShowModel) {
        if (isLoadingPage || self.seasons.count > 0) {
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
    }
    
}
