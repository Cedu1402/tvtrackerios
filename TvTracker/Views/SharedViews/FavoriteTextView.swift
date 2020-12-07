//
//  FavoriteTextView.swift
//  TvTracker
//
//  Created by Pasquale De Simone on 06.12.20.
//

import SwiftUI

struct FavoriteTextView: View {
    var show: ShowModel
    @EnvironmentObject var dataSource: ShowDataSource
    
    var body: some View {
        Text(getLatestEpisode())
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: 80,
                   alignment: .topLeading)
            .font(.system(size: 12))
        
        Text(getNextEpisode())
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: 80,
                   alignment: .topLeading)
            .font(.system(size: 12))
    }
    
    func getLatestEpisode() -> String {
        
        let episode = dataSource.getLatestEpisodeOfShow(show: show) as Episode?
        
        if(episode != nil){
            var epiStr = "Latest Episode: \n"
            
            if(episode?.title != nil) {
                epiStr += episode?.title ?? ""
                epiStr += " "
            }
            
            epiStr += "(" + dateFormatter.string(from: episode?.firstAired ?? Date()) + ")"
            
            return epiStr
            
        }
        
        return ""
    }
    
    func getNextEpisode() -> String {
        
        let episode = dataSource.getNextEpisodeOfShow(show: show) as Episode?
        
        if(episode != nil){
            var epiStr = "Next Episode: \n"
            
            if(episode?.title != nil) {
                epiStr += episode?.title ?? ""
                epiStr += " "
            }
            
            epiStr += "(" + dateFormatter.string(from: episode?.firstAired ?? Date()) + ")"
            
            return epiStr
            
        }
        
        return ""
    }
}

private var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM"
    return dateFormatter
}()

/*
struct FavoriteTextView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteTextView()
    }
}
*/
