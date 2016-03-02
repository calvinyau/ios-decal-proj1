//
//  AddToDoItemViewController.swift
//  ToDoList
//
//  Created by Calvin Yau on 3/1/16.
//  Copyright © 2016 Calvin Yau. All rights reserved.
//

import UIKit

class AddToDoItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var newItemText: UITextField!
    @IBOutlet var toDoListController: ToDoListTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newItemText.delegate = self
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let trimmedText = textField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        print(trimmedText)
        if (trimmedText != "") {
            if (toDoListController.itemsWithCompletion.indexForKey(textField.text!) != nil) {
                return false
            }
            textField.resignFirstResponder()
            let currDate : NSDate = NSDate()
            toDoListController.itemsWithDates[textField.text!] = currDate
            toDoListController.itemsWithCompletion[textField.text!] = false
            toDoListController.tableView.reloadData()
            
            self.performSegueWithIdentifier("unwindToItemList", sender: self)
            return true
        }
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}