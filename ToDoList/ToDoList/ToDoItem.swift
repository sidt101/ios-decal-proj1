//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Siddhant K Tandon on 2/26/16.
//  Copyright © 2016 Siddhant K Tandon. All rights reserved.
//

import UIKit

class ToDoItem {
    var text:String
    var timeUpdated:NSDate
    var taskCompleted:Bool
    
    init(text:String, timeUpdated:NSDate, taskCompleted:Bool) {
        self.text = text
        self.timeUpdated = timeUpdated
        self.taskCompleted = taskCompleted
    }
}
