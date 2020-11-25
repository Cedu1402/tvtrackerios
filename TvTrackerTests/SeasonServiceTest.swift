//
//  SeasonServiceTest.swift
//  TvTrackerTests
//
//  Created by cedric blaser on 24.11.20.
//

import XCTest
@testable import TvTracker


class SeasonServiceTest: XCTestCase {

    func testSeasonServiceApiCall() throws {
        let e = expectation(description: "Season service api request")
        
        SeasonService().getSeasons(showId: 2){ (data) in
            XCTAssertTrue(data.count > 0, "Check if seasons found")
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }

}
