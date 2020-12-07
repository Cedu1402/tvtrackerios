//
//  SeriesView.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 21.11.20.
//

import SwiftUI

struct ReleaseView: View {
    let dataSource = ShowDataSource(favorite: false)
    var body: some View {
        ShowListView(title: "Releases")
            .onAppear{
                self.dataSource.updateFavoriteFlags()
            }
            .environmentObject(dataSource)
    }
}

struct ReleaseView_Previews: PreviewProvider {
    static var previews: some View {
        ReleaseView()
    }
}
