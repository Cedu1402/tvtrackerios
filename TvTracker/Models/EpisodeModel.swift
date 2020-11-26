//
//  EpisodeModel.swift
//  TvTracker
//
//  Created by cedric blaser on 21.11.20.
//

import Foundation

struct EpisodeApiModel: Codable {
    let season: Int
    let number: Int
    let title: String
    let overview: String
    let first_aired: String?
    let runtime: Int
    let ids: EpisodeIdModel
}

struct EpisodeModel {
    let season: Int
    let number: Int
    let title: String
    let overview: String
    let firstAired: String?
    let runtime: Int
    let trakt: Int
    let imdb: String
    let tvdb: Int
}
