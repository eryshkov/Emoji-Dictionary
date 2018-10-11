//
//  EmojiTableViewController.swift
//  Emoji Dictionary
//
//  Created by Evgeniy Ryshkov on 08/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var emojis = Emojis.content
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return EmojiType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return EmojiType.allCases[section].rawValue.capitalized
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return getNumOfEmojiInSection(section)
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiTableViewCell", for: indexPath) as? EmojiTableViewCell else {fatalError("Cell is not EmojiTableViewCell")}

        let emojiSection = getEmojiSection(indexPath.section)
        let emoji = emojiSection[indexPath.row]
        
        cell.update(with: emoji)
//        cell.showsReorderControl = true

        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section == destinationIndexPath.section {
            let oldIndex = getEmojiAbsoluteIndex(indexPath: sourceIndexPath)
            let newIndex = getEmojiAbsoluteIndex(indexPath: destinationIndexPath)
            let movedEmojii = emojis.remove(at: oldIndex)
            emojis.insert(movedEmojii, at: newIndex)
            tableView.reloadData()
        }else {
            tableView.reloadData()
        }

    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

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

    // MARK: - IBActions
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "EmojiDetailSegue", sender: sender)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueID = segue.identifier else { return }
        
        switch segueID {
        case "EmojiDetailSegue":
            guard let dvc = segue.destination as? EmojiDetailTableViewController  else { return }
            if let emoji = sender as? Emoji {
                dvc.emoji = emoji
                dvc.previousTableView = tableView
            }
        default:
            break
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindToEmojiTableViewController(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emoji = emojis[getEmojiAbsoluteIndex(indexPath: indexPath)]
        print("\(emoji.symbol) - \(indexPath) abs=\(getEmojiAbsoluteIndex(indexPath: indexPath))")
        
        performSegue(withIdentifier: "EmojiDetailSegue", sender: emoji)
    }
    
    // MARK: - Emojis engine
    
    func getEmojiSection(_ section: Int) -> [Emoji] {
        return emojis.filter({ (emoji) -> Bool in
            return emoji.type == EmojiType.allCases[section]
        })
    }
    
    func getNumOfEmojiInSection(_ section: Int) -> Int {
        return getEmojiSection(section).count
    }
    
    func getEmojiAbsoluteIndex(indexPath: IndexPath) -> Int {
        var selectedSection = indexPath.section
        var currentSection = 0
        var absoluteIndex = 0
        
        
        while currentSection < selectedSection {
            absoluteIndex += getNumOfEmojiInSection(currentSection)
            currentSection += 1
        }
        
        return absoluteIndex + indexPath.row
    }
}
