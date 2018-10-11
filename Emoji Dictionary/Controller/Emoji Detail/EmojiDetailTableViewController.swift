//
//  EmojiDetailTableViewController.swift
//  Emoji Dictionary
//
//  Created by Evgeniy Ryshkov on 10/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import UIKit

class EmojiDetailTableViewController: UITableViewController {

    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var symbolText: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextField!
    
    @IBOutlet weak var usageLabel: UILabel!
    @IBOutlet weak var usageText: UITextField!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typePicker: UIPickerView!
    
    var emoji: Emoji?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutSetup()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func layoutSetup() {
        symbolLabel.text = "Эмоджи"
        nameLabel.text = "Название"
        descriptionLabel.text = "Описание"
        usageLabel.text = "Используется"
        typeLabel.text = "Тип"
        
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        
        if let emoji = self.emoji {
            symbolText.text = emoji.symbol
            nameText.text = emoji.name
            descriptionText.text = emoji.description
            usageText.text = emoji.usage
            let emojiTypeSelected = EmojiType.allCases.firstIndex(of: emoji.type)!
            typePicker.selectRow(emojiTypeSelected, inComponent: 1, animated: false)
        }
    }
    
    // MARK: - Table view data source


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

 // MARK: - Picker view data source
extension EmojiDetailTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return EmojiType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return EmojiType.allCases[row].rawValue
    }
}
