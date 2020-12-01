//
//  ReleaseRowView.swift
//  TvTracker
//
//  Created by cedric blaser on 30.11.20.
//

import Foundation
import SwiftUI

struct ShowRowView: View {
    
    var show: ShowModel
    @EnvironmentObject var dataSource: ShowDataSource
    
    var body: some View {
        HStack {
            ListImageView(url: show.imageURL)
                .frame(width: 68,
                       height: 100,
                       alignment: .topLeading)
                .cornerRadius(8)
            VStack {
                HStack {
                    Text(show.title)
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                        .font(.system(size: 18))
                    FavoriteStarView(show: show){
                        dataSource.changeFavoriteFlag(index: show.index)
                    }.environmentObject(dataSource)
                    .padding(.trailing, 10)
                }.padding(.bottom, 10)
                Text(show.overview)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: 80,
                           alignment: .topLeading)
                    .truncationMode(.tail)
                    .font(.system(size: 12))
            }.padding(.leading, 10)
        }
    }
}


struct ReleaseRowView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
     }

     struct PreviewWrapper: View {
        let dataSource = ShowDataSource(favorite: false)
        @State var show = ShowModel(
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
        ShowRowView(show: show)
            .environmentObject(self.dataSource)
       }
     }
}
