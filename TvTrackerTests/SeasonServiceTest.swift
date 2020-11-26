//
//  SeasonServiceTest.swift
//  TvTrackerTests
//
//  Created by cedric blaser on 24.11.20.
//

import XCTest
@testable import TvTracker


class SeasonServiceTest: XCTestCase {

    func test_GetSeasons_ValidInfos_ReturnsSesons() throws {
        let e = expectation(description: "Season service api request")
        
        SeasonService().getSeasons(imdb: "tt0903747"){ (data) in
            XCTAssertTrue(data.count > 0, "Check if seasons found")
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func test_GetSeasons_InvalidInfos_ReturnsNoSesons() throws {
        let e = expectation(description: "Season service api request")
        
        SeasonService().getSeasons(imdb: "blablalba"){ (data) in
            XCTAssertTrue(data.count == 0, "Check if seasons found")
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
}
