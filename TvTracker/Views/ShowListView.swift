//
//  ShowListView.swift
//  TvTracker
//
//  Created by cedric blaser on 30.11.20.
//

import SwiftUI

struct ShowListView: View {
    var title: String
    @EnvironmentObject var dataSource: ShowDataSource
    @State var searchText = ""
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dataSource.shows) {
                 show in
                    NavigationLink(
                        destination: ShowDetailView(show: show)) {
                        ShowRowView(show: show)
                            .environmentObject(self.dataSource)
                    }.onAppear {
                        dataSource.loadMoreContentIfNeeded(currentItem: show)
                    }
                }
                if dataSource.isLoadingPage {
                    ProgressView()
                }
            }.add(self.searchBar)
            .onReceive(self.searchBar.$text, perform: {_ in
                
            })
            .navigationBarTitle(self.title)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ShowListView_Previews: PreviewProvider {
    static let dataSource = ShowDataSource(favorite: false)
    
    static var previews: some View {
        ShowListView(title: "Preview")
            .environmentObject(self.dataSource)
    }
}
