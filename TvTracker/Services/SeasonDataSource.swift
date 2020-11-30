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

    public func loadContent(imdb: String) {
        
        if (isLoadingPage || self.seasons.count > 0) {
            return
        }

        isLoadingPage = true

        self.seasonService.getSeasons(imdb: imdb) { (data) in
            self.seasons.append(contentsOf: data)
            
            self.isLoadingPage = false
        }
    }
}
