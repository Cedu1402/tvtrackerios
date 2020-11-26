//
//  DateConvertTest.swift
//  TvTrackerTests
//
//  Created by cedric blaser on 26.11.20.
//

import XCTest
@testable import TvTracker

class ConvertToDateTest: XCTestCase {

    func test_convertToDate_validDate_returnsDate() throws {
        // Arrange
        let dateStr = "2014-08-29T23:16:39.000Z"
        // Act
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        let date = TraktApi.convertToDate(date: dateStr)
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        // Assert
        XCTAssertEqual("2014", year)
        XCTAssertEqual("08", month)
        XCTAssertEqual("29", day)
    }

}
