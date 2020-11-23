//
//  TvTrackerTests.swift
//  TvTrackerTests
//
//  Created by cedric blaser on 09.11.20.
//

import XCTest
@testable import TvTracker
import Alamofire

class TvTrackerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let e = expectation(description: "Alamofire")
        
        ShowService().getReleases(pageNr: 1) { (data) in
            var test = data
            XCTAssertTrue(true, "testestt")
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
