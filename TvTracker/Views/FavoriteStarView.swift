//
//  FavoriteStarView.swift
//  TvTracker
//
//  Created by cedric blaser on 22.11.20.
//

import SwiftUI

struct FavoriteStarView: View {
    @Binding var show: ShowModel
    let onFavorite: () -> Void
    @State private var showingAlert = false
    
    var body: some View {
        Button(action: {
            self.showingAlert = true
        }) {
            Image(systemName: "star.fill")
                .foregroundColor(show.favorite ? Color(red: 1, green: 0.85, blue: 0) : Color.gray)
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Favoriten"),
                  message: Text(self.show.favorite ?
                                    "\(self.show.title) aus Favoriten entfernen?" :
                                    "\(self.show.title) zu Favoriten hinzufügen?" ),
                  primaryButton: .default(Text("OK")){
                    self.onFavorite()
                  },
                  secondaryButton: .default(Text("Abbrechen"))
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
                  message: Text("\(show.title ?? "") aus Favoriten entfernen?"),
                  primaryButton: .default(Text("OK")){
                        self.onRemove()
                  },
                  secondaryButton: .default(Text("Abbrechen"))
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
        index: 1,
        title: "test show",
        overview: "",
        trakt: 0,
        imdb: "",
        tvdb: 0,
        imageURL: URL(string: "test.ch")!,
        favorite: true)

       var body: some View {
        FavoriteStarView(show: $show){
        }
       }
     }
}
