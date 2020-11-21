//
//  ContentView.swift
//  TvTracker
//
//  Created by cedric blaser on 09.11.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        TabView {
            ReleaseView()
                .tabItem  {
                    Image(systemName: "tv.fill")
                    Text("Releases")
                }
            FavoritesView()
                .tabItem  {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
