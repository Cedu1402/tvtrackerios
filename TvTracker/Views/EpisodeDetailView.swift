//
//  EpisodeDetailView.swift
//  TvTracker
//
//  Created by cedric blaser on 03.12.20.
//

import SwiftUI

struct EpisodeDetailView: View {
    @State var episode: EpisodeModel
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ListImageView(url: episode.imageUrl)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .offset(y: geometry.frame(in: .global).minY / 9)
                    .clipped()
            }.frame(height: 400)
            VStack(alignment: .leading) {
                Text(episode.title).font(.title)
                    .bold()
                Text(episode.overview)
                    .padding(.top, 10)
            }
        }
    }
}

struct EpisodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        EpisodeDetailView(episode: EpisodeModel(id: UUID(),
                                                season: 1,
                                                number: 1,
                                                title: "",
                                                overview: "",
                                                firstAired: Date(),
                                                runtime: 1,
                                                trakt: 1,
                                                imdb: "",
                                                tvdb: 1,
                                                imageUrl: URL(string: "https://www.seo-kueche.de/wp-content/uploads/2020/06/404-fehler-page-seiten-titel.jpg")!))
    }
}
