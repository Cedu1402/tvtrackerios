//
//  FileService.swift
//  TvTracker
//
//  Created by cedric blaser on 02.12.20.
//

import Foundation

struct FileService {
    
    static func saveImageToFileSystem(image: URL) -> URL {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let name = image.deletingPathExtension().lastPathComponent + "." + image.pathExtension
        let fileURL = documentsUrl.appendingPathComponent(name)
        do {
            let data = try Data(contentsOf: image) // not NSData !!
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print(error,"failed to save image")
            return image
        }
        return fileURL
    }
    
}
