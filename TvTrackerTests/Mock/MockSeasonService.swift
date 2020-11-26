//
//  MockSeasonService.swift
//  TvTrackerTests
//
//  Created by cedric blaser on 26.11.20.
//

import Foundation
@testable import TvTracker

class MockSeasonService : SeasonServiceProtocol {
    
    public static let name = "TestSeason"
    
    func getSeasons(imdb: String, completion: @escaping ([SeasonModel]) -> ()){
        var seasons = [SeasonModel]()
        let testSeason = SeasonModel(id: UUID(),
                                     title: MockSeasonService.name,
                                     overview: "",
                                     episodeCount: 1,
                                     airedEpisodes: 1,
                                     firstAired: Date(),
                                     number: 1,
                                     trakt: 1,
                                     tvdb: 1,
                                     tmdb: 1)
        
        seasons.append(testSeason)
        
        completion(seasons)
    }
    
}
