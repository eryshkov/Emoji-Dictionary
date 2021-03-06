//
//  EmojiDetailTableViewController.swift
//  Emoji Dictionary
//
//  Created by Evgeniy Ryshkov on 10/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import UIKit

class EmojiDetailTableViewController: UITableViewController {

    @IBOutlet weak var symbolText: UITextField!
    @IBOutlet weak var nameText: UITextField!    
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var usageText: UITextField!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    weak var emoji: Emoji?
    weak var emojis = Emojis.content
    var newIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutSetup()
    }

    func layoutSetup() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(hexValue: "#F7F7F7", alpha: 1.0)
//        tableView.isScrollEnabled = false
        
        if let emoji = self.emoji {
            symbolText.text = emoji.symbol
            nameText.text = emoji.name
            descriptionText.text = emoji.about
            usageText.text = emoji.usage
            if let emojiTypeSelected = emoji.getIndexOfType() {
                typePicker.selectRow(emojiTypeSelected, inComponent: 0, animated: false)
                print(emojiTypeSelected)
            }
        }
        
        saveButtonSetup(senders: [symbolText])
        delegateAllTextFields(rootView: view)
        hideKeyboard(view: view)
    }
    
    func saveButtonSetup(senders: [UITextField]) {
        for textField in senders {
            let sendersText = (textField.text!).trimmingCharacters(in: .whitespacesAndNewlines)
            if sendersText.isEmpty {
                saveButton.isEnabled = false
            }else{
                saveButton.isEnabled = true
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        print("\(#function)")
        if let emoji = self.emoji { //edit emoji
            emoji.symbol = symbolText.text!
            emoji.name = nameText.text!
            emoji.about = descriptionText.text!
            emoji.usage = usageText.text!
            let newSection = EmojiType.getTypeFrom(index: typePicker.selectedRow(inComponent: 0))!
            newIndexPath = emojis?.updateSectionFor(emoji: emoji, newSection: newSection)
//            print("\(#function) edit emoji")
        }else{ //new emoji
            let symbol = symbolText.text!
            let name = nameText.text!
            let description = descriptionText.text!
            let usage = usageText.text!
            let emojiType = EmojiType.getTypeFrom(index: typePicker.selectedRow(inComponent: 0))!
            let newEmoji = Emoji(symbol: symbol, name: name, description: description, usage: usage, type: emojiType)
            newIndexPath = emojis?.append(emoji: newEmoji)
//            print("\(#function) create emoji")
        }
        emojis?.saveToFile(withFilename: emojis!.fileName, fileExtension: emojis!.fileExtension)
        performSegue(withIdentifier: "unwindToEmojiTableViewController", sender: nil)
    }
    
    @IBAction func textFieldValueChanged(_ sender: UITextField) {
        let writtenText = (sender.text!).trimmingCharacters(in: .whitespacesAndNewlines)
        sender.text = writtenText
        guard writtenText.count < 2 else {
            sender.text = String(writtenText.first!)
            saveButtonSetup(senders: [sender])
            return
        }
        
        guard writtenText.count != 0 else {
            saveButtonSetup(senders: [sender])
            return
        }
        
        guard writtenText.isContainEmoji() else {
            sender.text?.removeAll()
            saveButtonSetup(senders: [sender])
            return
        }
        
        saveButtonSetup(senders: [sender])
    }
    
    // MARK: - UITableView DataSource
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DetailVCSections.allCases[section].rawValue
    }
    
    
}

 // MARK: - Picker view data source
extension EmojiDetailTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return EmojiType.allCasesCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return EmojiType.getTypeFrom(index: row)?.rawValue
    }
}

