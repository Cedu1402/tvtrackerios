//
//  SeasonPersistencySerivceTest.swift
//  TvTrackerTests
//
//  Created by cedric blaser on 26.11.20.
//

import XCTest
@testable import TvTracker

class SeasonPersistencySerivceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Arrange
        let context = PersistenceController.preview.container.viewContext
        let show = Show(context: context)
        show.title = "Test Show"
        let sut = SeasonPersistencyService(persistency: PersistenceController.preview, seasonService: MockSeasonService())
        
        // Act
        sut.saveSeasonOfShow(show: show)
        
        // Assert
        XCTAssertNotNil(show.seasons)
        XCTAssertTrue(show.seasons?.count == 1)
        let nameTest = show.seasons?.contains(where: { (season) -> Bool in
            return (season as! Season).title == MockSeasonService.name
        })
        XCTAssertTrue(nameTest!)
    }

}
