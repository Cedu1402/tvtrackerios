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
        VStack(alignment: .leading) {
            ListImageView(url: show.imageURL)
                .edgesIgnoringSafeArea(.top)
                .frame(maxWidth: .infinity, maxHeight: 100)
            
            Text(show.overview)
            
        }
        
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
         overview: "",
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
