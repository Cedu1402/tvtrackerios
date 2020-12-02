//
//  MockSeasonService.swift
//  TvTrackerTests
//
//  Created by cedric blaser on 26.11.20.
//

import Foundation
@testable import TvTracker

class MockSeasonService : SeasonServiceProtocol {
    
    public static let name1 = "TestSeason"
    public static let name2 = "TestSeason2"
    
    func getSeasons(show: ShowModel, completion: @escaping ([SeasonModel]) -> ()){
        var seasons = [SeasonModel]()
        let testSeason = SeasonModel(id: UUID(),
                                     title: MockSeasonService.name1,
                                     overview: "",
                                     episodeCount: 1,
                                     airedEpisodes: 1,
                                     firstAired: Date(),
                                     number: 1,
                                     trakt: 1,
                                     tvdb: 1,
                                     tmdb: 1,
                                     imageUrl: URL(string: "https://www.seo-kueche.de/wp-content/uploads/2020/06/404-fehler-page-seiten-titel.jpg")!)
        
        let testSeason2 = SeasonModel(id: UUID(),
                                     title: MockSeasonService.name2,
                                     overview: "",
                                     episodeCount: 1,
                                     airedEpisodes: 1,
                                     firstAired: Date(),
                                     number: 1,
                                     trakt: 1,
                                     tvdb: 1,
                                     tmdb: 1,
                                     imageUrl: URL(string: "https://www.seo-kueche.de/wp-content/uploads/2020/06/404-fehler-page-seiten-titel.jpg")!)
        
        seasons.append(testSeason)
        seasons.append(testSeason2)
        
        completion(seasons)
    }
    
}
