//
//  SearchBarView.swift
//  TvTracker
//
//  Created by cedric blaser on 30.11.20.
//

import SwiftUI

class SearchBar: NSObject {
    
    var text: String = ""
    let search: (String) -> ()
    let cancel: () -> ()
    
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    init(search: @escaping (String) -> (), cancel: @escaping () -> ()) {
        self.search = search
        self.cancel = cancel
        
        super.init()
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
    }
    
    
}

extension SearchBar: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search(self.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.cancel()
    }
}


extension SearchBar: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
        // Publish search bar text changes.
        if let searchBarText = searchController.searchBar.text {
            self.text = searchBarText
        }
    }
}

struct SearchBarModifier: ViewModifier {
    
    let searchBar: SearchBar
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ViewControllerResolver { viewController in
                    viewController.navigationItem.searchController = self.searchBar.searchController
                }
                    .frame(width: 0, height: 0)
            )
    }
}

extension View {
    func add(_ searchBar: SearchBar) -> some View {
        return self.modifier(SearchBarModifier(searchBar: searchBar))
    }
}
