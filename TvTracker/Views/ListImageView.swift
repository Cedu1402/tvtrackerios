//
//  ListImageView.swift
//  TvTracker
//
//  Created by cedric blaser on 21.11.20.
//

import Foundation
import SwiftUI
import URLImage


struct ListImageView: View {
    var url: URL
    
    var body: some View {
        URLImage(url: url,
                         options: URLImageOptions(),
                         empty: {
                            Text("Nothing here") // This view is displayed before download starts
                         },
                         inProgress: { progress -> Text in  // Display progress

                            return Text("Loading...").font(.system(size: 12))
                         },
                         failure: { error, retry in         // Display error and retry button
                            VStack{
                                Image(systemName: "xmark.circle")
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                                    .overlay(Circle().stroke(lineWidth: 1))
                            }
                           
                         },
                         content: { image in                // Content view
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Rectangle())
                         })
    }
}


struct ListImageView_Previews: PreviewProvider {
    static var previews: some View {
        ListImageView(url: URL(string: "https://www.thetvdb.com/banners/posters/121361-1.jpg")!)
    }
}
