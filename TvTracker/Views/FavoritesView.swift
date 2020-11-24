//
//  FavoritesView.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 21.11.20.
//

import SwiftUI

struct FavoritesView: View {
    
    @Environment(\.managedObjectContext) var context

    @FetchRequest(
        entity: Show.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Show.titel, ascending: false)]
    ) var shows: FetchedResults<Show>
    
    var body: some View {
        ForEach(shows) {
         show in
            /* HStack {
                ListImageView(url: show)
                    .frame(width: 68,
                           height: 100)
                    .cornerRadius(8)
                VStack {
                    HStack {
                        Text(show.title ?? "not found")
                            .frame(maxWidth: .infinity,
                                   alignment: .leading)
                            .font(.system(size: 18))
                    }.padding(.bottom, 10)
                    Text(show.overview ?? "not found")
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               minHeight: 0,
                               maxHeight: 80,
                               alignment: .topLeading)
                        .truncationMode(.tail)
                        .font(.system(size: 12))
                }.padding(.leading, 10)*/
            }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
