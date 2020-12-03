//
//  EpisodeServiceTest.swift
//  TvTrackerTests
//
//  Created by cedric blaser on 26.11.20.
//

import XCTest
@testable import TvTracker

class EpisodeServiceTest: XCTestCase {

    func test_GetEpisodes_validInfos_returnsEpisodes() throws {
        let e = expectation(description: "episode service api request")
        
        EpisodeService().getEpisodes(show: ShowModel(id: UUID(),
                                                     title: "",
                                                     overview: "",
                                                     trakt: 0,
                                                     imdb: "tt0903747",
                                                     tvdb: 0,
                                                     tmdb: 0,
                                                     imageURL: URL(string: "test.ch")!,
                                                     bannerImageURL: URL(string: "test.ch")!,
                                                     favorite: false), season: 1){ (data) in
            XCTAssertTrue(data.count > 0, "Check if episodes found")
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }

    
    func test_getEpisodes_invalidInfos_returnsNoEpisodes() throws {
        let e = expectation(description: "episode service api request")
        
        EpisodeService().getEpisodes(show: ShowModel(id: UUID(),
                                                     title: "",
                                                     overview: "",
                                                     trakt: 0,
                                                     imdb: "afsdfasdfdsa",
                                                     tvdb: 0,
                                                     tmdb: 0,
                                                     imageURL: URL(string: "test.ch")!,
                                                     bannerImageURL: URL(string: "test.ch")!,
                                                     favorite: false), season: 1){ (data) in
            XCTAssertTrue(data.count == 0, "Check if episodes found")
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
}

