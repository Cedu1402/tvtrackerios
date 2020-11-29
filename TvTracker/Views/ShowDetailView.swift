//
//  ShowDetailView.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 24.11.20.
//

import SwiftUI

struct ShowDetailView: View {
    @Binding var show: ShowModel
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ListImageView(url: show.imageURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .offset(y: geometry.frame(in: .global).minY/9)
                    .clipped()
            }.frame(height: 400)
            VStack(alignment: .leading) {
                Text(show.title).font(.title)
                    .bold()
                Text(show.overview)
                    .padding(.top, 10)
                
            }.frame(width: 300)
        }.edgesIgnoringSafeArea(.top)
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
         imageURL: URL(string: "https://image.tmdb.org/t/p/original/p7fwOnlxYYlB4A8U2b0JfX21Rr1.jpg")!,
         favorite: true)

        var body: some View {
         ShowDetailView(show: $show)
        }
      }
}
