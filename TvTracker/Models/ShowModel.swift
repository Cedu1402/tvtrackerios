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
    let overview: String?
    let ids: TraktIdModel
}

struct SearchModel: Codable {
    let show: ShowDetailModel
}

struct ShowModel : Identifiable {
    var id: UUID
    let title: String
    let overview: String
    let trakt: Int
    let imdb: String
    let tvdb: Int
    let tmdb: Int
    var imageURL: URL
    var bannerImageURL: URL
    var favorite: Bool
    
    
   static func convertFromShow(show: Show, index: Int) -> ShowModel {
       return ShowModel(id: UUID(),
                 title: show.title ?? "",
                 overview: show.overview ?? "",
                 trakt: Int(show.trakt),
                 imdb: show.imdb ?? "",
                 tvdb: Int(show.trakt),
                 tmdb: Int(show.trakt),
                 imageURL: show.imageURL ?? URL(string: "https://www.seo-kueche.de/wp-content/uploads/2020/06/404-fehler-page-seiten-titel.jpg")!,
                 bannerImageURL: show.bannerImageURL ?? (show.imageURL ?? URL(string: "https://www.seo-kueche.de/wp-content/uploads/2020/06/404-fehler-page-seiten-titel.jpg")!),
                 favorite: true)
    }
}
