//
//  TMDBImageModel.swift
//  TvTracker
//
//  Created by cedric blaser on 29.11.20.
//

import Foundation


struct TMDBImages : Codable {
    let id: Int
    let backdrops: [TMDBImageInfo]
    let posters: [TMDBImageInfo]
}


struct TMDBImageInfo : Codable {
    let file_path: String
    let vote_average: Decimal
}


struct TMDBSeasonImages : Codable {
    let id: Int
    let posters: [TMDBImageInfo]
}
