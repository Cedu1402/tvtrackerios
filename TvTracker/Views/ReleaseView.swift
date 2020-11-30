//
//  SeriesView.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 21.11.20.
//

import SwiftUI
import URLImage

struct ReleaseView: View {
    
    @State var searchText = ""
    @State private var showingAlert = false
    @StateObject var dataSource = ReleaseDataSource()
    let showService = ShowService()
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(text: $searchText)
                ForEach(dataSource.shows) {
                 show in
                    NavigationLink(
                        destination: ShowDetailView(show: $dataSource.shows[show.index])) {
                        ReleaseRowView(dataSource: dataSource, index: show.index)
                    }.onAppear {
                        dataSource.loadMoreContentIfNeeded(currentItem: show)
                    }
                }
                if dataSource.isLoadingPage {
                    ProgressView()
                }
            }.navigationBarTitle("Releases")
        }

    }
}

struct ReleaseView_Previews: PreviewProvider {
    static var previews: some View {
        ReleaseView()
    }
}
