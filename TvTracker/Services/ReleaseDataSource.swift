//
//  ReleaseDataSource.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 22.11.20.
//

import Foundation

class ReleaseDataSource: ObservableObject {
    @Published var shows = [ShowModel]()
    @Published var isLoadingPage = false
    
    private var currentPage = 1
    private var canLoadMorePages = true
    private let showService = ShowService()

    init() {
        loadMoreContent()
    }

    func loadMoreContentIfNeeded(currentItem show: ShowModel?) {
        guard let show = show else {
            loadMoreContent()
            return
        }

        let thresholdIndex = shows.index(shows.endIndex, offsetBy: -5)
        if shows.firstIndex(where: { $0.id == show.id }) == thresholdIndex {
            loadMoreContent()
        }
    }
    
    func changeFavoriteFlag(show: ShowModel){
        if(!show.favorite){
            self.showService.saveAsFavorite(show: show)
            let index = self.shows.firstIndex(where: { (s) -> Bool in
                s.trakt == show.trakt // test if this is the item you're looking for
            })
            var mutableShow = show
            self.objectWillChange.send()
            mutableShow.favorite = true
            self.shows.remove(at: index!)
            self.shows.insert(mutableShow, at: index!)
            // self.shows.append(mutableShow)
        }else {
            let index = self.shows.firstIndex(where: { (s) -> Bool in
                s.trakt == show.trakt // test if this is the item you're looking for
            })
            var mutableShow = show
            mutableShow.favorite = false
            self.shows.remove(at: index!)
            self.shows.insert(mutableShow, at: index!)
        }
    }
    

    private func loadMoreContent() {
        guard !isLoadingPage && canLoadMorePages else {
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
