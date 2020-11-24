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
        sortDescriptors: [NSSortDescriptor(keyPath: \Show.title, ascending: true)]
    ) var shows: FetchedResults<Show>
    
    @State private var showingAlert = false
    
    
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
                            Text(show.title ?? "")
                                .frame(maxWidth: .infinity,
                                       alignment: .leading)
                                .font(.system(size: 18))
                            FavoriteStarDeleteOnlyView(show: show) {
                                self.context.delete(show)
                                try? self.context.save()
                            }.padding(.trailing, 10)
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
        testShow.title = "Test Title"
        testShow.overview = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo"
        
        return FavoritesView().environment(\.managedObjectContext, context)
    }
}
