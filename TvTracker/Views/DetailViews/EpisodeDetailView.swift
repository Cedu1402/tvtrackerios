//
//  EpisodeDetailView.swift
//  TvTracker
//
//  Created by cedric blaser on 03.12.20.
//

import SwiftUI

struct EpisodeDetailView: View {
    @State var episode: EpisodeModel
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            GeometryReader{reader in
                            
                // Parallax
                if reader.frame(in: .global).minY > -220 {
                    ListImageView(url: episode.imageUrl)
                        .aspectRatio(contentMode: .fill)
                        .offset(y: -reader.frame(in: .global).minY + 80)
                        .frame(width: UIScreen.main.bounds.width, height:  reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + 220 : 220)
                }
            }
            .frame(height: 300)
            
            VStack(alignment: .leading) {
                Text(episode.title).font(.title)
                    .bold()
                
                Text("First aired: \(episode.firstAired, formatter: dateFormatter)")
                    .padding(.top, 12)
                
                if(episode.runtime > 0) {
                    Text("Runtime: \(episode.runtime) min")
                        .padding(.top, 8)
                }
                
                Text(episode.overview)
                    .padding(.vertical, 10)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 200, maxHeight: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
            .padding(.top, 12)
            .background(Color.white)
        }
    }
}

private var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    return dateFormatter
}()

struct EpisodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        EpisodeDetailView(episode: EpisodeModel(id: UUID(),
                                                season: 1,
                                                number: 1,
                                                title: "",
                                                overview: "",
                                                firstAired: Date(),
                                                runtime: 1,
                                                trakt: 1,
                                                imdb: "",
                                                tvdb: 1,
                                                imageUrl: URL(string: "https://www.seo-kueche.de/wp-content/uploads/2020/06/404-fehler-page-seiten-titel.jpg")!))
    }
}
