//
//  StatsViewController.swift
//  ToDoList
//
//  Created by Siddhant K Tandon on 2/27/16.
//  Copyright © 2016 Siddhant K Tandon. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var numberOfTasksCompleted: UILabel!
    var toPass:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfTasksCompleted.text = toPass
    }
    
}
