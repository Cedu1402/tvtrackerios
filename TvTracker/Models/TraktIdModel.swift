//
//  ShowIDModel.swift
//  TvTracker
//
//  Created by cedric blaser on 21.11.20.
//

import Foundation

struct TraktIdModel: Codable {
    let trakt: Int
    let imdb: String?
    let tvdb: Int?
    let tmdb: Int?
}

struct SeasonIdModel: Codable {
    let trakt: Int
    let tvdb: Int?
    let tmdb: Int?
}


struct EpisodeIdModel: Codable {
    let trakt: Int
    let tvdb: Int?
    let tmdb: Int?
    let imdb: String?
}
