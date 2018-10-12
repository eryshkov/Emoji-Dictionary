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
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return EmojiType.allCasesCount()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return EmojiType.getTypeFrom(index: section)?.rawValue.capitalized
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return emojis.getEmojiInSectionCount(section)!
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiTableViewCell", for: indexPath) as? EmojiTableViewCell else {fatalError("Cell is not EmojiTableViewCell")}
        
        let emoji = emojis.getEmojiFor(indexPath: indexPath)!
        cell.update(with: emoji)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath.section == destinationIndexPath.section {
            if let movedEmoji = emojis.removeEmojiFor(indexPath: sourceIndexPath) {
                emojis.insert(emoji: movedEmoji, at: destinationIndexPath)
            }
        }else {
            if let movedEmoji = emojis.removeEmojiFor(indexPath: sourceIndexPath) {
                emojis.insert(emoji: movedEmoji, at: destinationIndexPath)
                movedEmoji.type = EmojiType.getTypeFrom(index: destinationIndexPath.section)!
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "EmojiDetailSegue", sender: sender)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueID = segue.identifier else { return }
        
        switch segueID {
        case "EmojiDetailSegue":
            guard let dvc = segue.destination as? EmojiDetailTableViewController  else { return }
            if let emoji = sender as? Emoji {
                dvc.emoji = emoji
            }
        default:
            break
        }
    }
    
    
    @IBAction func unwindToEmojiTableViewController(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "unwindToEmojiTableViewController" {
            guard let prevViewController = unwindSegue.source as? EmojiDetailTableViewController else {return}
            if let oldCellIndexPath = tableView.indexPathForSelectedRow {
                // edit emoji
                if let newCellIndexPath = prevViewController.newIndexPath {
                    if oldCellIndexPath == newCellIndexPath {
                        tableView.reloadRows(at: [newCellIndexPath], with: .fade)
                    }else{
                        tableView.moveRow(at: oldCellIndexPath, to: newCellIndexPath)
                    }
                }
            }else{
                // add emoji
                if let newCellIndexPath = prevViewController.newIndexPath {
                    tableView.insertRows(at: [newCellIndexPath], with: .fade)
                    
                }
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emoji = emojis.getEmojiFor(indexPath: indexPath)
        print("\(emoji?.symbol ?? "") - \(indexPath)")
        
        performSegue(withIdentifier: "EmojiDetailSegue", sender: emoji)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            _ = emojis.removeEmojiFor(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }
    
}
