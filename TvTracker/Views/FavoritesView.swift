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
        List{
            ForEach(shows) {
             show in
                HStack {
                    ListImageView(url: show.imageURL ?? URL(string: "Failed")!)
                        .frame(width: 68,
                               height: 100)
                        .cornerRadius(8)
                    VStack {
                        HStack {
                            Text(show.titel ?? "not found")
                                .frame(maxWidth: .infinity,
                                       alignment: .leading)
                                .font(.system(size: 18))
                            /*FavoriteStarView(show: ShowModel(id: UUID(),
                                                             index: 1,
                                                             title: show.titel ?? "",
                                                             overview: show.overview ?? "",
                                                             trakt: Int(show.trakt ?? 1),
                                                             imdb: show.imdb ?? "",
                                                             tvdb: Int(show.tvdb ?? 1),
                                                             imageURL: show.imageURL ?? URL(string: "Failed")!,
                                                             favorite: true)){
                                // dataSource.changeFavoriteFlag(index: show.index)
                            }.padding(.trailing, 10) */
                        }.padding(.bottom, 10)
                        Text(show.overview ?? "not found")
                            .frame(minWidth: 0,
                                   maxWidth: .infinity,
                                   minHeight: 0,
                                   maxHeight: 80,
                                   alignment: .topLeading)
                            .truncationMode(.tail)
                            .font(.system(size: 12))
                    }.padding(.leading, 10)
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let testShow = Show(context: context)
        testShow.titel = "Test Title"
        testShow.overview = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo"
        
        return FavoritesView().environment(\.managedObjectContext, context)
    }
}
