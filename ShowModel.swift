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
    
    private enum CodingKeys: String, CodingKey {
        case title, overview, ids
        
    }
}


