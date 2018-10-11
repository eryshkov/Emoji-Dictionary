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

class Emoji: Equatable, CustomStringConvertible {
    
    var symbol: String
    var name: String
    var about: String
    var usage: String
    var type: EmojiType
    
    var description: String {
        return symbol
    }
    
    init(symbol: String, name: String, description: String, usage: String, type: EmojiType) {
        self.symbol = symbol
        self.name = name
        self.about = description
        self.usage = usage
        self.type = type
    }
    
    static func == (lhs: Emoji, rhs: Emoji) -> Bool {
        return lhs.symbol == rhs.symbol
    }
    
    func getIndexOfType() -> Int? {        
        return EmojiType.allCases.firstIndex(of: self.type)
    }
}
