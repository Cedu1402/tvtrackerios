//
//  AboutView.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 30.11.20.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
    
        
        VStack{
            Text("TV Tracker").font(.title).bold()
            
            Text("powered by").frame(width: .infinity, alignment: .center)
            
            
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

    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
