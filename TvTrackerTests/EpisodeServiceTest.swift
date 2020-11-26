//
//  EpisodeServiceTest.swift
//  TvTrackerTests
//
//  Created by cedric blaser on 26.11.20.
//

import XCTest
@testable import TvTracker

class EpisodeServiceTest: XCTestCase {

    func testEpisodeServiceApiCall() throws {
        let e = expectation(description: "episode service api request")
        
        EpisodeService().getEpisodes(imdb: "tt0903747", season: 1){ (data) in
            XCTAssertTrue(data.count > 0, "Check if episodes found")
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }

}

