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
    
    let showService = ShowService()

    func getSeries(){
       self.showService.getReleases { (data) in
          self.shows.append(contentsOf: data)
        }
    }
    
    var body: some View {
        List(shows) {
            show in
            HStack {
                ListImageView(url: show.imageURL)
                Text(show.title)
            }
        }.onAppear(perform: getSeries)
    }
}

struct SeriesView_Previews: PreviewProvider {
    static var previews: some View {
        ReleaseView()
    }
}
