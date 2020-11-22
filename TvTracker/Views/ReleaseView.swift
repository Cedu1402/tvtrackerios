//
//  SeriesView.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 21.11.20.
//

import SwiftUI
import URLImage

struct ReleaseView: View {
    
    @State var shows = [ShowModel]()
    @State var searchText = ""
    
    @StateObject var dataSource = ReleaseDataSource()
    
    let showService = ShowService()

    func getSeries(){
        self.showService.getReleases(pageNr: 1) { (data) in
          self.shows.append(contentsOf: data)
        }
    }
    
    var body: some View {
        
        NavigationView {
            List {
                SearchBar(text: $searchText)
                
                ForEach(dataSource.shows) {
                    show in
                    NavigationLink(
                        destination: /* HIER RICHTIGE VIEW*/ EmptyView()) {
                            HStack {
                                ListImageView(url: show.imageURL).frame(width: 68, height: 100).cornerRadius(8)
                                VStack {
                                    HStack {
                                        Text(show.title).frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 18))
                                        Image(systemName: "star.fill").foregroundColor(Color(red: 1, green: 0.85, blue: 0)).padding(.trailing, 10)
                                        
                                    }.padding(.bottom, 10)
                                    Text(show.overview).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80, alignment: .topLeading).truncationMode(.tail).font(.system(size: 12))
                                    
                                }.padding(.leading, 10)
                            }
                    }
                }

                if dataSource.isLoadingPage {
                    ProgressView()
                }
            }
        }
    }
}

struct SeriesView_Previews: PreviewProvider {
    static var previews: some View {
        ReleaseView()
    }
}
