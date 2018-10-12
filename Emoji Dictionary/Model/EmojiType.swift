//
//  EmojiType.swift
//  Emoji Dictionary
//
//  Created by Evgeniy Ryshkov on 12/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

enum EmojiType: String, CaseIterable {
    case animal = "Животные", smile = "Смайлы", other = "Прочие"
    
    static func getTypeFrom(index: Int) -> EmojiType? {
        if index < EmojiType.allCases.count && index >= 0 {
            return EmojiType.allCases[index]
        }
        
        return nil
    }
}
