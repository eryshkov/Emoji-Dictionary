//
//  Emojis.swift
//  Emoji Dictionary
//
//  Created by Evgeniy Ryshkov on 11/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import UIKit
class Emojis: CustomStringConvertible, Codable {
    
    
    static var content = Emojis()
    
    let fileName = "emojis"
    let fileExtension = "plist"
    
    var storage: [EmojiType:[Emoji]] = [EmojiType:[Emoji]]()
//        [
//        EmojiType.animal:[
//            Emoji(symbol: "🐢", name: "Черепаха", description: "Зеленая черепаха", usage: "медленное движение", type: .animal),
//            Emoji(symbol: "🐰", name: "Заяц", description: "Заяц с ушами", usage: "быстрое движение", type: .animal),
//            Emoji(symbol: "🐱", name: "Кошка", description: "Желтый кот", usage: "хитрое поведение", type: .animal),
//            Emoji(symbol: "🐶", name: "Собака", description: "Типичный пёс", usage: "открытое поведение", type: .animal),
//        ],
//        EmojiType.smile:[
//            Emoji(symbol: "😀", name: "Смайлик", description: "Улыбающаяся мордочка", usage: "полное счастье", type: .smile),
//            Emoji(symbol: "😇", name: "Ангел", description: "Мордочка с нимбом", usage: "хорошие поступки", type: .smile),
//            Emoji(symbol: "😍", name: "Влюбленный", description: "Влюбленная мордочка", usage: "состояние влюбленности", type: .smile),
//        ],
//        EmojiType.other:[
//            Emoji(symbol: "🧦", name: "Носки", description: "Трикотажное изделие", usage: "надеть на ноги", type: .other),
//        ],
//    ]
    
    private init() {readFromFile(withFilename: fileName, fileExtension: fileExtension)}
    
    var description: String {
        var result = ""
        for (key, value) in storage {
            result += "\(key.rawValue):\(value)\n"
        }
        return result
    }
    
     // MARK: - Emojis engine
    
    func append(emoji: Emoji) -> IndexPath? {
        if var currentSection = storage[emoji.type] {
            currentSection.append(emoji)
            let raw = currentSection.firstIndex(of: emoji)!
            let section = emoji.getIndexOfType()!
            storage.updateValue(currentSection, forKey: emoji.type)
            return IndexPath(item: raw, section: section)
        }
        
        return nil
    }
    
    func updateSectionFor(emoji: Emoji, newSection: EmojiType) -> IndexPath? {
        var oldSection = storage[emoji.type]!
        
        if emoji.type != newSection {
            let oldRow = oldSection.firstIndex(of: emoji)
            oldSection.remove(at: oldRow!)
            storage.updateValue(oldSection, forKey: emoji.type)
            var newSectionArray = storage[newSection]!
            emoji.type = newSection
            newSectionArray.append(emoji)
            storage.updateValue(newSectionArray, forKey: newSection)
            
            let newRow = newSectionArray.count - 1
            let newSectionColumn = emoji.getIndexOfType()!
            return IndexPath(item: newRow, section: newSectionColumn)
        }else{
            guard let currentRow = oldSection.firstIndex(of: emoji) else {return nil}
            let newSectionColumn = emoji.getIndexOfType()!
            return IndexPath(item: currentRow, section: newSectionColumn)
        }
        
    }
    
    func getEmojiFor(indexPath: IndexPath) -> Emoji? {
        var foundEmoji: Emoji? = nil
        if var currentSection = storage[EmojiType.getTypeFrom(index: indexPath.section)!] {
            foundEmoji = currentSection[indexPath.row]
        }
        return foundEmoji
    }
    
    func removeEmojiFor(indexPath: IndexPath) -> Emoji? {
        var foundEmoji: Emoji? = nil
        let key = EmojiType.getTypeFrom(index: indexPath.section)!
        if var currentSection = storage[key] {
            foundEmoji = currentSection.remove(at: indexPath.row)
            storage.updateValue(currentSection, forKey: key)
        }
        return foundEmoji
    }
    
    func insert(emoji: Emoji, at indexPath: IndexPath) {
        let key = EmojiType.getTypeFrom(index: indexPath.section)!
        if var currentSection = storage[EmojiType.getTypeFrom(index: indexPath.section)!] {
            currentSection.insert(emoji, at: indexPath.row)
            storage.updateValue(currentSection, forKey: key)
        }
    }
    
    func getEmojiSection(_ section: Int) -> [Emoji]? {
        return storage[EmojiType.getTypeFrom(index: section)!]
    }
    
    func getEmojiInSectionCount(_ section: Int) -> Int? {
        return getEmojiSection(section)?.count
    }
    

}
