//
//  SeasonModel.swift
//  TvTracker
//
//  Created by cedric blaser on 21.11.20.
//

import Foundation

struct SeasonApiModel: Codable {
    let title: String
    let overview: String
    let episode_count: Int
    let aired_episodes: Int
    let first_aired: String?
    let number: Int
    let ids: SeasonIdModel
}


struct SeasonModel : Identifiable {
    var id: UUID
    let title: String
    let overview: String
    let episodeCount: Int
    let airedEpisodes: Int
    let firstAired: Date
    let number: Int
    let trakt: Int
    let tvdb: Int
    let tmdb: Int
}

