//
//  SeasonServiceProtocol.swift
//  TvTracker
//
//  Created by cedric blaser on 26.11.20.
//

import Foundation

protocol SeasonServiceProtocol {
    func getSeasons(imdb: String, completion: @escaping ([SeasonModel]) -> ())
}

