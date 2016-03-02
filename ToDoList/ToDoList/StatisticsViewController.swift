//
//  StatisticsViewController.swift
//  ToDoList
//
//  Created by Calvin Yau on 3/1/16.
//  Copyright © 2016 Calvin Yau. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    var completedItems : Int!
    
    @IBOutlet weak var annoucementText1: UILabel!
    @IBOutlet weak var announcementText2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        announcementText2.text = String(completedItems)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
