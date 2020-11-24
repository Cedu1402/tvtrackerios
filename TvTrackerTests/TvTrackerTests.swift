//
//  TvTrackerTests.swift
//  TvTrackerTests
//
//  Created by cedric blaser on 09.11.20.
//

import XCTest
@testable import TvTracker

class TvTrackerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowServiceApiCall() throws {
        
        let e = expectation(description: "Show service api request")
        
        ShowService().getReleases(pageNr: 1) { (data) in
            XCTAssertTrue(data.count > 0, "Check if shows found")
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    

}
