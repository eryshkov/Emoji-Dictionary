//
//  KeyboardHide.swift
//  Emoji Dictionary
//
//  Created by Evgeniy Ryshkov on 14/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import UIKit

// MARK: - Hides keyboard on RETURN Button
extension EmojiDetailTableViewController: UITextFieldDelegate{
    
    // Hides keyboard on RETURN Button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        print("\(#function) executed")
        textField.resignFirstResponder()
        return true
    }
    
    //Must call in the viewDidLoad() for example
    func delegateAllTextFieldsAt(tableView: UITableView) {
        for cell in tableView.visibleCells {
            for someView in getAllSubviews(rootView: cell) {
                if let someTextField = someView as? UITextField {
                    someTextField.delegate = self
                    //                        print("Text field detected")
                }
            }
            
        }
    }
    
    //Must call in the viewDidLoad() for example
    func delegateAllTextFields(rootView: UIView) {
        for someView in getAllSubviews(rootView: rootView) {
            
            if let someTextField = someView as? UITextField {
                someTextField.delegate = self
                //                print("Text field detected")
            }
            if let someTableView = someView as? UITableView {
                delegateAllTextFieldsAt(tableView: someTableView)
            }
        }
    }
    
    func getAllSubviews(rootView: UIView) -> [UIView] {
        
        var flatArray: [UIView] = []
        flatArray.append(rootView)
        
        for subview in rootView.subviews {
            flatArray += getAllSubviews(rootView: subview)
        }
        return flatArray
    }
}

// MARK: - Hides Keyboard on Touch Outside
extension UIViewController {
    
    //Must call in the viewDidLoad() for example
    func hideKeyboard(view: UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

