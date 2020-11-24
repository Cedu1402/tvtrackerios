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
        sortDescriptors: [NSSortDescriptor(keyPath: \Show.title, ascending: false)]
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
                            Text(show.title ?? "not found")
                                .frame(maxWidth: .infinity,
                                       alignment: .leading)
                                .font(.system(size: 18))
                            Button(action: {
                                self.showingAlert = true
                            }){
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color(red: 1, green: 0.85, blue: 0))
                            }.alert(isPresented: $showingAlert) {
                                Alert(title: Text("Favoriten"),
                                      message: Text("\(show.title ?? "") aus Favoriten entfernen?"),
                                      primaryButton: .default(Text("OK")){
                                        // self.onFavorite()
                                      },
                                      secondaryButton: .default(Text("Abbrechen"))
                                )
                            }.buttonStyle(PlainButtonStyle())
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
