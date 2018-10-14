//
//  EmojiTableViewCell.swift
//  Emoji Dictionary
//
//  Created by Evgeniy Ryshkov on 08/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    func update(with emoji: Emoji) {
        symbolLabel.text = emoji.symbol
        nameLabel.text = emoji.name
        aboutLabel.text = emoji.about
        
        if emoji.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            nameLabel.textColor = UIColor.gray
            nameLabel.text = "Без имени"
        }else{
            nameLabel.textColor = UIColor.black
        }
        
        if emoji.about.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            aboutLabel.text = "Без описания"
            print("Без описания")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
