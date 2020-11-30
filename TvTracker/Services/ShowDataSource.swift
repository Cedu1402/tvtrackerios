//
//  ReleaseDataSource.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 22.11.20.
//

import Foundation

class ShowDataSource: ObservableObject {
    
    @Published var shows = [ShowModel]()
    @Published var isLoadingPage = false
    
    private var currentPage = 1
    private var canLoadMorePages = true
    private let showService = ShowService()
    private let showPersitencyService = ShowPersistencyService(persistency: PersistenceController.shared)
    private var favoriteView: Bool
    
    init(favorite: Bool) {
        favoriteView = favorite
        if !favorite {
            loadMoreContent()
        }
    }
    
    func loadFavorites(reload: Bool?) {
        if(reload != nil && reload!){
            self.shows.removeAll()
        }
        let favorites =  showPersitencyService.getFavorites()
        for (index, show) in favorites.enumerated()  {
            self.shows.append(ShowModel(id: UUID(),
                                        index: index,
                                        title: show.title ?? "",
                                        overview: show.overview ?? "",
                                        trakt: Int(show.trakt),
                                        imdb: show.imdb ?? "",
                                        tvdb: Int(show.trakt),
                                        tmdb: Int(show.trakt),
                                        imageURL: show.imageURL!,
                                        favorite: true))
        }
    }

    func loadMoreContentIfNeeded(currentItem show: ShowModel?) {
        if(self.favoriteView){
            return
        }
        
        guard let show = show else {
            loadMoreContent()
            return
        }

        let thresholdIndex = shows.index(shows.endIndex, offsetBy: -5)
        if shows.firstIndex(where: { $0.id == show.id }) == thresholdIndex {
            loadMoreContent()
        }
    }
    
    func updateFavoriteFlags(){
        for (index, show) in shows.enumerated() {
            if show.favorite != self.showPersitencyService.isFavorite(trakt: show.trakt){
                changeFavoriteFlag(index: index)
            }
        }
    }
    
    func changeFavoriteFlag(index: Int){
        let show = self.shows[index]
        var mutableShow = show
        if(!show.favorite){
            self.showPersitencyService.saveAsFavorite(show: show)
            mutableShow.favorite = true
        }else {
            self.showPersitencyService.removeFavorite(show: show)
            mutableShow.favorite = false
        }
        if self.favoriteView {
            self.loadFavorites(reload: true)
        }else {
            self.shows[index] = mutableShow
        }
    }

    private func loadMoreContent() {
        guard (!isLoadingPage && canLoadMorePages) || self.favoriteView else {
          return
        }

        isLoadingPage = true

        self.showService.getReleases(pageNr: self.currentPage) { (data) in
            
            self.shows.append(contentsOf: data)
            self.isLoadingPage = false
            self.currentPage += 1
            
            if data.count < 10 {
                self.canLoadMorePages = false
            }
        }
    }
}
