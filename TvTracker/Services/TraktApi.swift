//
//  ApiKez.swift
//  TvTracker
//
//  Created by cedric blaser on 21.11.20.
//

import Foundation


struct TraktApi {
     static let key = "c01bdbd9fcf60d1977707d76e78d76dfd72472e1267070b7451dabe557759685"
     static let baseUrl = "https://api.trakt.tv/"
    
    
    static func createTraktRequest(url: String) -> URLRequest? {
    
        guard let traktUrl = URL(string:  TraktApi.baseUrl + url) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: traktUrl)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("2", forHTTPHeaderField: "trakt-api-version")
        urlRequest.setValue(TraktApi.key, forHTTPHeaderField: "trakt-api-key")
        
        return urlRequest
    }
    
    
    static func convertToDate(date: String?) -> Date {
        guard let dateStr = date else {
            return Date()
        }
        let formatter = DateFormatter()
        // Trakt api returns dates in utc. 
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.date(from: dateStr) ?? Date()

    }
}


