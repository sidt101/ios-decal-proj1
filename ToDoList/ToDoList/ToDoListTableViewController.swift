//
//  ToDoListTableViewController
//  ToDoList
//
//  Created by Siddhant K Tandon on 2/26/16.
//  Copyright © 2016 Siddhant K Tandon. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    
    //1.Model
    var listOfToDoItems:[ToDoItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteAndUpdateTasks()
        //initialize model once here
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "statsViewSegue") {
            let navc = segue.destinationViewController as! UINavigationController
            let svc = navc.topViewController as! StatsViewController
            svc.toPass = numberOfTasksCompletedToday()
        }
    }
    
    @IBAction func unwindToDoListTableViewController(segue: UIStoryboardSegue) {
    
    }
    
    func numberOfTasksCompletedToday() ->String {
        var tasksCompletedToday:Int = 0
        deleteAndUpdateTasks()
        for item in listOfToDoItems {
            if item.taskCompleted {
                tasksCompletedToday += 1
            }
        }
        return String(tasksCompletedToday)
    }
    
    
    @IBAction func unwindAndSaveToDoListTableViewController(segue: UIStoryboardSegue) {
        let addToDoItemSourceViewController : AddToDoItemViewController = segue.sourceViewController as! AddToDoItemViewController
        if let toDoItemText = addToDoItemSourceViewController.newToDoItem.text {
            let toDoItemObject = ToDoItem(text:toDoItemText, timeUpdated:NSDate(), taskCompleted:false)
            listOfToDoItems.append(toDoItemObject)
            self.tableView.reloadData()

        }
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "To-Do Tasks"
    }
    
    func deleteAndUpdateTasks() {
        for (index,item) in listOfToDoItems.enumerate().reverse() {
            if item.taskCompleted && (NSDate().timeIntervalSinceDate(item.timeUpdated)/86400 > 1) {
                listOfToDoItems.removeAtIndex(index)
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell", forIndexPath: indexPath) as! ToDoListTableViewCell
        cell.toDoItemTextLabel.text = listOfToDoItems[indexPath.row].text
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfToDoItems.count
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            listOfToDoItems.removeAtIndex(indexPath.row)
        }
        self.tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .Checkmark {
                cell.accessoryType = .None
                listOfToDoItems[indexPath.row].taskCompleted = false
                listOfToDoItems[indexPath.row].timeUpdated = NSDate()
            } else {
                cell.accessoryType = .Checkmark
                listOfToDoItems[indexPath.row].taskCompleted = true
                listOfToDoItems[indexPath.row].timeUpdated = NSDate()
            }
        }    
    }

}

