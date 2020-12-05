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
    @ObservedObject var dataSource: SeasonDataSource;
    var isFavoriteView: Bool
    
    init(isFavoriteView: Bool, show: ShowModel){
        self.dataSource = SeasonDataSource(favoriteView: isFavoriteView, show: show)
        self.show = show
        self.isFavoriteView = isFavoriteView
    }
    
    var body: some View {
        ScrollView {
            GeometryReader{reader in
                            
                // Parallax
                if reader.frame(in: .global).minY > -220 {
                    ListImageView(url: show.bannerImageURL)
                        .aspectRatio(contentMode: .fill)
                        .offset(y: -reader.frame(in: .global).minY + 80)
                        .frame(width: UIScreen.main.bounds.width, height:  reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + 220 : 220)
                }
            }
            .frame(height: 300)
            
            VStack(alignment: .leading) {
                Text(show.title).font(.title)
                    .bold()
                Text(show.overview)
                    .padding(.top, 10)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                VStack {
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
                            destination: SeasonDetailView(isFavoriteView: self.isFavoriteView,
                                                          show: self.show,
                                                          season: season)){
                            Text(season.title).frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Divider()
                    }
                    if dataSource.isLoadingPage {
                        ProgressView()
                    }
                }
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding(.horizontal, 10)
            .padding(.top, 12)
            .background(Color.white)
        }
        .onReceive(self.dataSource.$seasons, perform: { _ in
            self.dataSource.loadContent()
        })
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
         title: "test show",
         overview: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.",
         trakt: 0,
         imdb: "",
         tvdb: 0,
            tmdb: 0,
         imageURL: URL(string: "https://image.tmdb.org/t/p/original/p7fwOnlxYYlB4A8U2b0JfX21Rr1.jpg")!,
         bannerImageURL: URL(string: "https://image.tmdb.org/t/p/original/p7fwOnlxYYlB4A8U2b0JfX21Rr1.jpg")!,
         favorite: true)

        var body: some View {
         ShowDetailView(isFavoriteView: false, show: show)
        }
      }
}
