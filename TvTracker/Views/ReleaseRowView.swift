//
//  ReleaseRowView.swift
//  TvTracker
//
//  Created by cedric blaser on 30.11.20.
//

import Foundation
import SwiftUI

struct ReleaseRowView: View {
    
    @ObservedObject var dataSource: ReleaseDataSource
    @State var index: Int
    
    var body: some View {
        HStack {
            ListImageView(url: dataSource.shows[index].imageURL)
                .frame(width: 68,
                       height: 100,
                       alignment: .topLeading)
                .cornerRadius(8)
            VStack {
                HStack {
                    Text(dataSource.shows[index].title)
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                        .font(.system(size: 18))
                    FavoriteStarView(show: $dataSource.shows[index]){
                        dataSource.changeFavoriteFlag(index: index)
                    }.padding(.trailing, 10)
                }.padding(.bottom, 10)
                Text(dataSource.shows[index].overview)
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


struct ReleaseRowView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
     }

     struct PreviewWrapper: View {
        @StateObject() var dataSource = ReleaseDataSource()
        let index = 0
        
       var body: some View {
            ReleaseRowView(dataSource: dataSource, index: index)
       }
     }
}
