//
//  SeasonPersistencySerivceTest.swift
//  TvTrackerTests
//
//  Created by cedric blaser on 26.11.20.
//

import XCTest
@testable import TvTracker

class SeasonPersistencySerivceTest: XCTestCase {

    func test_saveSeasonOfShow_createsRelationToShow() throws {
        // Arrange
        let context = PersistenceController.preview.container.viewContext
        let show = Show(context: context)
        show.title = "Test Show"
        let sut = SeasonPersistencyService(persistency: PersistenceController.preview, seasonService: MockSeasonService())
        
        // Act
        sut.saveSeasonOfShow(show: show)
        
        // Assert
        XCTAssertNotNil(show.seasons)
        XCTAssertTrue(show.seasons?.count == 2)
        let nameTest1 = show.seasons?.contains(where: { (season) -> Bool in
            return (season as! Season).title == MockSeasonService.name1
        })
        XCTAssertTrue(nameTest1!)
        
        let nameTest2 = show.seasons?.contains(where: { (season) -> Bool in
            return (season as! Season).title == MockSeasonService.name2
        })
        XCTAssertTrue(nameTest2!)
    }

}
