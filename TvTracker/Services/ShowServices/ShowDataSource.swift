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
    @Published var favoriteView: Bool
    
    private var currentPage = 1
    private var canLoadMorePages = true
    private let showService = ShowService()
    private let showPersitencyService = ShowPersistencyService(persistency: PersistenceController.shared)
    
    
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
        for show in favorites  {
            self.shows.append(ShowModel(id: UUID(),
                                        title: show.title ?? "",
                                        overview: show.overview ?? "",
                                        trakt: Int(show.trakt),
                                        imdb: show.imdb ?? "",
                                        tvdb: Int(show.trakt),
                                        tmdb: Int(show.trakt),
                                        imageURL: show.imageURL!,
                                        bannerImageURL: show.bannerImageURL ?? show.imageURL!,
                                        favorite: true))
        }
    }
    
    func isFavorite(show: ShowModel) -> Bool{
        guard let found = self.shows.first(where: { s -> Bool in
            s.trakt == show.trakt
        })else {
            return false
        }
        return found.favorite
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
        for show in shows {
            if show.favorite != self.showPersitencyService.isFavorite(trakt: show.trakt){
                changeFavoriteFlag(show: show)
            }
        }
    }
    
    func changeFavoriteFlag(show: ShowModel){
        guard let index = self.shows.firstIndex(where: { (s) -> Bool in
            s.trakt == show.trakt
        }) else {
            return
        }
        
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
    
    
    func searchShows(query: String, initialize: Bool){
        if initialize {
            self.currentPage = 1
            self.canLoadMorePages = true
            self.shows.removeAll()
        }
        isLoadingPage = true
        
        if self.favoriteView {
          let result = self.showPersitencyService.serachShow(text: query)
          for show in result  {
                self.shows.append(ShowModel(id: UUID(),
                                            title: show.title ?? "",
                                            overview: show.overview ?? "",
                                            trakt: Int(show.trakt),
                                            imdb: show.imdb ?? "",
                                            tvdb: Int(show.trakt),
                                            tmdb: Int(show.trakt),
                                            imageURL: show.imageURL!,
                                            bannerImageURL: show.bannerImageURL ??  show.imageURL!,
                                            favorite: true))
            }
            isLoadingPage = false
        }else{
            self.showService.searchShow(query: query, pageNr: self.currentPage) { (shows) in
                
                self.shows.append(contentsOf: shows)
                self.isLoadingPage = false
                self.currentPage += 1
                
                if shows.count < 10 {
                    self.canLoadMorePages = false
                }
            }
        }
    }
    
    func searchMoreShows(show: ShowModel, query: String){
        if(self.favoriteView){
            return
        }
        
        guard (!isLoadingPage && canLoadMorePages) else {
          return
        }
        
        let thresholdIndex = shows.index(shows.endIndex, offsetBy: -5)
        if shows.firstIndex(where: { $0.id == show.id }) == thresholdIndex {
            searchShows(query: query, initialize: false)
        }
    }
    
    func resetSearch(){
        if(favoriteView){
            self.loadFavorites(reload: true)
        }else {
            self.shows.removeAll()
            self.currentPage = 1
            self.canLoadMorePages = true
            self.loadMoreContent()
        }
    }
    
    func getLatestEpisodeOfShow(show: ShowModel) -> Episode? {
        if(show.favorite) {
            
            var seasons = self.showPersitencyService.getSeasonsOfShow(imdb: show.imdb)
            
            seasons?.sort {
                $0.number > $1.number
            }
            
            for season in seasons! {
                var episodes = self.showPersitencyService.getEpisodesOfShowAndSeason(imdb: show.imdb, number: Int(season.number))
                
                episodes?.sort {
                    $0.number > $1.number
                }
                
                for episode in episodes! {
                    if(Date() > episode.firstAired!) {
                        return episode
                    }
                }
            }
        }
        
        return nil
    }
    
    func getNextEpisodeOfShow(show: ShowModel) -> Episode? {
        if(show.favorite) {
            
            var seasons = self.showPersitencyService.getSeasonsOfShow(imdb: show.imdb)
            
            seasons?.sort {
                $0.number < $1.number
            }
            
            for season in seasons! {
                var episodes = self.showPersitencyService.getEpisodesOfShowAndSeason(imdb: show.imdb, number: Int(season.number))
                
                episodes?.sort {
                    $0.number < $1.number
                }
                
                for episode in episodes! {
                    if(Date() <= episode.firstAired!) {
                        return episode
                    }
                }
            }
        }
        
        return nil
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

