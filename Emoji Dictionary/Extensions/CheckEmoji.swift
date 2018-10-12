//
//  CheckEmoji.swift
//  Emoji Dictionary
//
//  Created by Evgeniy Ryshkov on 12/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

extension String {
    func isContainEmoji() -> Bool {
        let isContain = unicodeScalars.first(where: { $0.isEmoji }) != nil
        return isContain
    }
}


extension UnicodeScalar {
    
    var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F,
             0x1F300...0x1F5FF,
             0x1F680...0x1F6FF,
             0x1F1E6...0x1F1FF,
             0x2600...0x26FF,
             0x2700...0x27BF,
             0xFE00...0xFE0F,
             0x1F900...0x1F9FF,
             65024...65039,
             8400...8447,
             9100...9300,
             127000...127600:
            return true
        default:
            return false
        }
    }
    
}
