//
//  SeasonDetailView.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 30.11.20.
//

import SwiftUI

struct SeasonDetailView: View {
    var season: SeasonModel
    @ObservedObject var dataSource: EpisodeDataSource;
    
    init(isFavoriteView: Bool, show: ShowModel, season: SeasonModel){
        self.season = season
        self.dataSource = EpisodeDataSource(favoriteView: isFavoriteView,
                                            show: show,
                                            season: season.number)
    }
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ListImageView(url: season.imageUrl)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .offset(y: geometry.frame(in: .global).minY / 9)
                    .clipped()
            }.frame(height: 400)
            VStack(alignment: .leading) {
                Text(season.title).font(.title)
                    .bold()
                Text(season.overview)
                    .padding(.top, 10)
                LazyVStack {
                    if(dataSource.episodes.count > 0) {
                        Text("Episodes")
                            .font(.subheadline)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 10)
                    }
                    ForEach(dataSource.episodes) {
                     episode in
                        NavigationLink(
                            destination: EmptyView()){
                            Text(String(episode.number) + " - " + episode.title).frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Divider()
                    }
                    if dataSource.isLoadingPage {
                        ProgressView()
                    }
                }
            }
        }
    }
}

struct SeasonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonDetailView(isFavoriteView: false,
                         show: ShowModel(id: UUID(),
                                        title: "TEST",
                                        overview: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                                        trakt: 1,
                                        imdb: "",
                                        tvdb: 1,
                                        tmdb: 1,
                                        imageURL: URL(string: "https://www.seo-kueche.de/wp-content/uploads/2020/06/404-fehler-page-seiten-titel.jpg")!,
                                        bannerImageURL: URL(string: "https://www.seo-kueche.de/wp-content/uploads/2020/06/404-fehler-page-seiten-titel.jpg")!,
                                        favorite: false),
                         season: SeasonModel(id: UUID(),
                                             title: "TEST",
                                             overview: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                                             episodeCount: 1,
                                             airedEpisodes: 1,
                                             firstAired: Date(),
                                             number: 1,
                                             trakt: 1,
                                             tvdb: 1,
                                             tmdb: 1,
                                             imageUrl: URL(string: "https://www.seo-kueche.de/wp-content/uploads/2020/06/404-fehler-page-seiten-titel.jpg")!))
    }
}
