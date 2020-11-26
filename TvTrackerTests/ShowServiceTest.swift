//
//  TvTrackerTests.swift
//  TvTrackerTests
//
//  Created by cedric blaser on 09.11.20.
//

import XCTest
@testable import TvTracker

class ShowServiceTest: XCTestCase {
    
    func test_getReleases_valid_returnsShows() throws {
        
        let e = expectation(description: "Show service api request")
        
        ShowService().getReleases(pageNr: 1) { (data) in
            XCTAssertTrue(data.count > 0, "Check if shows found")
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
