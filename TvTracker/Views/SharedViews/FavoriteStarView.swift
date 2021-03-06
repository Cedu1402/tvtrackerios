//
//  FavoriteStarView.swift
//  TvTracker
//
//  Created by cedric blaser on 22.11.20.
//

import SwiftUI

struct FavoriteStarView: View {
    var show: ShowModel
    let onFavorite: () -> Void
    @State private var showingAlert = false
    @EnvironmentObject var dataSource: ShowDataSource
    
    var body: some View {
        Button(action: {
            self.showingAlert = true
        }) {
            if(dataSource.isFavorite(show: show)) {
                Image(systemName: "star.fill")
                    .foregroundColor(Color(red: 1, green: 0.85, blue: 0))
            }
            else
            {
                Image(systemName: "star")
                    .foregroundColor(Color.gray)
            }
            
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Favoriten"),
                  message: Text(self.show.favorite ?
                                    "Remove \(self.show.title) from favorites?" :
                                    "Add \(self.show.title) to favorites?" ),
                  primaryButton: .default(Text("OK")){
                    self.onFavorite()
                  },
                  secondaryButton: .default(Text("Cancel"))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}


struct FavoriteStarDeleteOnlyView: View {
    
    var show: Show
    let onRemove: () -> Void
    @State private var showingAlert = false
    
    var body: some View {
        Button(action: {
            self.showingAlert = true
        }){
            Image(systemName: "star.fill")
                .foregroundColor(Color(red: 1, green: 0.85, blue: 0))
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Favoriten"),
                  message: Text("Remove \(show.title ?? "") from favorites?"),
                  primaryButton: .default(Text("OK")){
                        self.onRemove()
                  },
                  secondaryButton: .default(Text("Cancel"))
            )
        }.buttonStyle(PlainButtonStyle())
    }
    
}

struct FavoriteStarView_Previews: PreviewProvider {

    static var previews: some View {
        PreviewWrapper()
     }

     struct PreviewWrapper: View {
       @State() var show =  ShowModel(
        id: UUID(),
        title: "test show",
        overview: "",
        trakt: 0,
        imdb: "",
        tvdb: 0,
        tmdb: 0,
        imageURL: URL(string: "test.ch")!,
        bannerImageURL: URL(string: "test.ch")!,
        favorite: true)

       var body: some View {
        FavoriteStarView(show: show){
        }
       }
     }
}
