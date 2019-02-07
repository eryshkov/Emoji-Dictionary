//
//  CRUDPlist.swift
//  Emoji Dictionary
//
//  Created by Evgeniy Ryshkov on 17/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import Foundation

extension Emojis {
    func getWorkingDirectory(withFilename: String, fileExtension: String) -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(withFilename).appendingPathExtension(fileExtension)
        
        return archiveURL
    }
    
    func saveToFile(withFilename: String, fileExtension: String) {
        let plistEncoder = PropertyListEncoder()
        let encodedEmojis = try? plistEncoder.encode(self.storage)
        
        let emojisURL = getWorkingDirectory(withFilename: withFilename, fileExtension: fileExtension)
        try? encodedEmojis?.write(to: emojisURL)
    }
    
    func readFromFile(withFilename: String, fileExtension: String) {
        let plistDecoder = PropertyListDecoder()
        let emojisURL = getWorkingDirectory(withFilename: withFilename, fileExtension: fileExtension)
        if let encodedEmojis = try? Data(contentsOf: emojisURL) {
            if let decodedEmojis = try? plistDecoder.decode([EmojiType:[Emoji]].self, from: encodedEmojis) {
                self.storage = decodedEmojis
            }
        }else{
            let path = Bundle.main.path(forResource: self.fileName, ofType: self.fileExtension)!
            let urlPath = URL(fileURLWithPath: path)
            if let encodedEmojis = try? Data(contentsOf: urlPath) {
                if let decodedEmojis = try? plistDecoder.decode([EmojiType:[Emoji]].self, from: encodedEmojis) {
                    self.storage = decodedEmojis
                }
            }
        }
    }
}
