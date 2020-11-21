//
//  SeasonModel.swift
//  TvTracker
//
//  Created by cedric blaser on 21.11.20.
//

import Foundation

struct SeasonApiModel: Codable {
    let titel: String
    let episode_count: Int
    let aired_episodes: Int
    let first_aired: Date
    let number: Int
    let ids: TraktIdModel
}


struct SeasonModel : Identifiable {
    var id: UUID
    let episodeCount: Int
    let airedEpisodes: Int
    let firstAired: Date
    let number: Int
    let trakt: Int
    let imdb: String
    let tvdb: Int
}

