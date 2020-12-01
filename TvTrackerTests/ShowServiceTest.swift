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
    
    func test_GetImageUrl() throws {
        // 113956
        let e = expectation(description: "Show service api request")
        
        ShowService().getImageUrl(tmdb: 113956) { url in
            XCTAssertTrue(url!.count > 0, "Check if shows found")
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_searchShow() throws {
        // 113956
        let e = expectation(description: "Show service api request")
        
        ShowService().searchShow(query: "Breaking Bad") { data in
            XCTAssertTrue(data.count > 0, "Check if shows found")
            e.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }

}
