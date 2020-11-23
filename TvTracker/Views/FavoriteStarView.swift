//
//  FavoriteStarView.swift
//  TvTracker
//
//  Created by cedric blaser on 22.11.20.
//

import SwiftUI

struct FavoriteStarView: View {
    
    var show: ShowModel
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showingAlert = false
    
    var body: some View {
        Button(action: {
            print("Button was tapped")
            self.showingAlert = true
        }) {
            Image(systemName: "star.fill")
                .foregroundColor(self.show.favorite ?
                                    Color(red: 1, green: 0.85, blue: 0) : Color.gray)
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Favoriten"),
                  message: Text(self.show.favorite ?
                                    "\(self.show.title) aus Favoriten entfernen?" :
                                    "\(self.show.title) zu Favoriten hinzufügen?" ),
                  primaryButton: .default(Text("OK")){
                    saveAsFavorite()
                  },
                  secondaryButton: .default(Text("Abbrechen"))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func saveAsFavorite(){
        let show = Show(context: managedObjectContext)
        show.titel = self.show.title
        show.overview = self.show.overview
        show.imdb = self.show.imdb
        show.tvdb = Int64(self.show.tvdb)
        show.trakt = Int64(self.show.trakt)
        show.imageURL = self.show.imageURL
    }
}

struct FavoriteStarView_Previews: PreviewProvider {
    
    static var previews: some View {
        FavoriteStarView(show: ShowModel(
                            id: UUID(),
                            title: "test show",
                            overview: "",
                            trakt: 0,
                            imdb: "",
                            tvdb: 0,
                            imageURL: URL(string: "test.ch")!,
                            favorite: true))
    }
}

