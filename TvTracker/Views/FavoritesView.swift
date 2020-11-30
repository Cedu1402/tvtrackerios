//
//  FavoritesView.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 21.11.20.
//

import SwiftUI

struct FavoritesView: View {
    let dataSource = ShowDataSource(favorite: true)
    var body: some View {
        ShowListView(title: "Favorites")
            .onAppear{
                self.dataSource.loadFavorites(reload: true)
            }
            .environmentObject(dataSource)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        return FavoritesView()
    }
}
