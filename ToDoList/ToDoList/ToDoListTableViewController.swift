//
//  ViewController.swift
//  ToDoList
//
//  Created by Calvin Yau on 3/1/16.
//  Copyright © 2016 Calvin Yau. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    var itemsWithCompletion = [String : Bool]()
    var itemsWithDates = [String: NSDate]()
    var completedItems : Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        let dictKeys = Array(itemsWithCompletion.keys)
        
        for key in dictKeys {
            let timeSince = NSDate().timeIntervalSinceDate(itemsWithDates[key]!);
            
            if (itemsWithCompletion[key]! && timeSince > 86400) {
                itemsWithCompletion.removeValueForKey(key)
                itemsWithDates.removeValueForKey(key)
                
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToToDoListTableViewController(segue: UIStoryboardSegue) {
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var keys = Array(itemsWithCompletion.keys).sort()
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoListCell", forIndexPath: indexPath)
        cell.textLabel!.text = keys[indexPath.row]
        
        if (itemsWithCompletion[keys[indexPath.row]] == true) {
            cell.accessoryType = .Checkmark
        }
        else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsWithCompletion.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            var keys = Array(itemsWithCompletion.keys).sort()
            if cell.accessoryType != .Checkmark {
                cell.accessoryType = .Checkmark
                itemsWithCompletion[keys[indexPath.row]] = true
                let currDate = NSDate()
                itemsWithDates[keys[indexPath.row]] = currDate
            }
            else {
                cell.accessoryType = .None
                itemsWithCompletion[keys[indexPath.row]] = false
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAddItemSegue" {
            let view = segue.destinationViewController as! AddToDoItemViewController
            view.toDoListController = self
        }
        else if segue.identifier == "toStatsSegue" {
            let dictValues = Array(itemsWithCompletion.values)
            completedItems = 0
            for each in dictValues {
                if each == true {
                    completedItems = completedItems + 1
                }
            }
            
            let statisticsView = segue.destinationViewController as! StatisticsViewController
            statisticsView.completedItems = completedItems
        }
    }

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let compKeys = Array(itemsWithCompletion.keys).sort()
        let dateKeys = Array(itemsWithDates.keys).sort()
        itemsWithCompletion.removeValueForKey(compKeys[indexPath.row])
        itemsWithDates.removeValueForKey(dateKeys[indexPath.row])
        self.tableView.reloadData()
        
    }

}

