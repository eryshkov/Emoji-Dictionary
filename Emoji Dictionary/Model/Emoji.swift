//
//  Emoji.swift
//  Emoji Dictionary
//
//  Created by Evgeniy Ryshkov on 08/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import Foundation

enum EmojiType: String, CaseIterable {
    case animal = "Животные", smile = "Смайлы", other = "Прочие"
}

class Emoji {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    var type: EmojiType
    
    init(symbol: String, name: String, description: String, usage: String, type: EmojiType) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
        self.type = type
    }
    
    func getIndexOfType() -> Int? {
        for (index, item) in EmojiType.allCases.enumerated() {
            if item == self.type { return index}
        }
        
        return nil
    }
}
