//
//  ShowDetailView.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 24.11.20.
//

import SwiftUI

struct ShowDetailView: View {
    var show: ShowModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var dataSource = SeasonDataSource()
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ListImageView(url: show.bannerImageURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .offset(y: geometry.frame(in: .global).minY / 9)
                    .clipped()
            }.frame(height: 400)
            VStack(alignment: .leading) {
                Text(show.title).font(.title)
                    .bold()
                Text(show.overview)
                    .padding(.top, 10)
                
                LazyVStack {
                    if(dataSource.seasons.count > 0) {
                        Text("Seasons")
                            .font(.subheadline)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 10)
                    }
                    ForEach(dataSource.seasons) {
                     season in
                        NavigationLink(
                            destination: EmptyView()){
                            Text(season.title).frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Divider()
                    }
                    if dataSource.isLoadingPage {
                        ProgressView()
                    }
                }
                
                
            }
            .padding(.horizontal, 10)
        }
        .onAppear {
            dataSource.loadContent(imdb: show.imdb)
        }
        .navigationBarTitle(Text(show.title), displayMode: .inline)
    
    }
}

struct ShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewShowDetailWrapper()
      }

      struct PreviewShowDetailWrapper: View {
        @State() var show =  ShowModel(
         id: UUID(),
         index: 1,
         title: "test show",
         overview: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
         trakt: 0,
         imdb: "",
         tvdb: 0,
            tmdb: 0,
         imageURL: URL(string: "https://image.tmdb.org/t/p/original/p7fwOnlxYYlB4A8U2b0JfX21Rr1.jpg")!,
         bannerImageURL: URL(string: "https://image.tmdb.org/t/p/original/p7fwOnlxYYlB4A8U2b0JfX21Rr1.jpg")!,
         favorite: true)

        var body: some View {
         ShowDetailView(show: show)
        }
      }
}
