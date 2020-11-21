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
    
    let showService = ShowService()

    func getSeries(){
       self.showService.getReleases { (data) in
          self.shows.append(contentsOf: data)
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText).padding(.top, 10)
            
            List(shows) {
                show in
                HStack {
                    ListImageView(url: show.imageURL).frame(width: 68, height: 100).cornerRadius(8).shadow(radius: 4)
                    VStack {
                        HStack {
                            Text(show.title).frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 18))
                            Image(systemName: "star.fill").foregroundColor(Color(red: 1, green: 0.85, blue: 0)).padding(.trailing, 10)
                            
                        }.padding(.bottom, 10)
                        Text(show.overview).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80, alignment: .topLeading).truncationMode(.tail).font(.system(size: 12))
                        
                    }.padding(.leading, 10)
                }
            }.onAppear(perform: getSeries)
        }
        
       
    }
}

struct SeriesView_Previews: PreviewProvider {
    static var previews: some View {
        ReleaseView()
    }
}
