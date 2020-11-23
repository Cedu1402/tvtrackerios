//
//  ShowModel.swift
//  TvTracker
//
//  Created by cedric blaser on 21.11.20.
//

import Foundation

struct ShowApiModel: Codable {
    let show: ShowDetailModel
}

struct ShowDetailModel: Codable {
    let title: String
    let overview: String
    let ids: TraktIdModel
}

struct ShowModel : Identifiable {
    var id: UUID
    let title: String
    let overview: String
    let trakt: Int
    let imdb: String
    let tvdb: Int
    let imageURL: URL
    let favorite: Bool
}



