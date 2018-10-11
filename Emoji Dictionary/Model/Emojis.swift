//
//  Emojis.swift
//  Emoji Dictionary
//
//  Created by Evgeniy Ryshkov on 11/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

class Emojis {
    static var content: [Emoji] = [
        Emoji(symbol: "🐢", name: "Черепаха", description: "Зеленая черепаха", usage: "медленное движение", type: .animal),
        Emoji(symbol: "🐰", name: "Заяц", description: "Заяц с ушами", usage: "быстрое движение", type: .animal),
        Emoji(symbol: "🐱", name: "Кошка", description: "Желтый кот", usage: "хитрое поведение", type: .animal),
        Emoji(symbol: "🐶", name: "Собака", description: "Типичный пёс", usage: "открытое поведение", type: .animal),
        Emoji(symbol: "😀", name: "Смайлик", description: "Улыбающаяся мордочка", usage: "полное счастье", type: .smile),
        Emoji(symbol: "😇", name: "Ангел", description: "Мордочка с нимбом", usage: "хорошие поступки", type: .smile),
        Emoji(symbol: "😍", name: "Влюбленный", description: "Влюбленная мордочка", usage: "состояние влюбленности", type: .smile),
        Emoji(symbol: "🧦", name: "Носки", description: "Трикотажное изделие", usage: "надеть на ноги", type: .other),
        ]
    
    private init() {}
}
