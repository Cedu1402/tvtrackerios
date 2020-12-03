//
//  AboutView.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 30.11.20.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading){
            Image("tvtracker_logo")
                .resizable()
                .scaledToFit()
            
            
            Text("Version 1.0.0")
                .padding(.top, 20)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            
            
            
            Text("Created by")
                .padding(.top, 20)
                .padding(.bottom, 2)
            Text("Cedric Blaser")
            Text("Luca Sommer")
            
            Text("powered by")
                .padding(.top, 100)
            
            HStack {
                Image("trakttv_logo")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 10)
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                Image("tmdb_logo")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 10)
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            }
            
            Spacer()

        }
        .padding(.all, 20)
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)

    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
