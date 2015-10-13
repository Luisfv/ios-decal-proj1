//
//  ToDoListTableViewController.swift
//  To-Do List
//
//  Created by Luis Vasquez on 10/9/15.
//  Copyright © 2015 Luis Vasquez. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController, MyProtocol {
    
    var tasks = [ToDoItem]()
    
//    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var label = UILabel.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        self.refreshControl?.tintColor = UIColor.whiteColor()
        
        self.tasks = [] //userDefaults.objectForKey("tasks") as! [ToDoItem] // GET TASKS STORED SOMEWHERE or just empty
        if self.tasks.isEmpty {
//            self.tasks.append(ToDoItem())
        }
        
        self.setup()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        for task in self.tasks {
            if task.isExpired() && task.isComplete() {
                self.tasks.removeAtIndex(self.tasks.indexOf(task)!)
            }
        }
        self.tableView.reloadData()
    }
    
    func setup() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addTasks")
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.blueColor()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Stats", style: UIBarButtonItemStyle.Plain, target: self, action: "showStats")
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.blueColor()
        
        self.navigationItem.title = "To-Do List"
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init()
        
        self.view.backgroundColor = UIColor.darkGrayColor()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.rowHeight = 60
        if self.tasks.isEmpty {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
            label = UILabel(frame: CGRectMake(45, 80, 225, 150))
            //            label.center = self.view.center
            label.font = UIFont.boldSystemFontOfSize(22)
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            label.numberOfLines = 0
            label.textColor = UIColor.lightGrayColor()
            label.textAlignment = NSTextAlignment.Center
            label.text = "You don't have any tasks right now. You've been really productive or really lazy!"

            self.view.addSubview(label)
        }

    }
    
    func refresh() {
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    func addTasks() {
        performSegueWithIdentifier("add", sender: nil)
    }
    
    func showStats() {
        performSegueWithIdentifier("stats", sender: nil)

    }
    
    func tasksComplete() -> Int {
        var complete = 0
        for task in tasks {
            if task.isComplete() {
                complete += 1
            }
        }
        
        return complete
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tasks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        }

        // Configure the cell...
        
        var task : ToDoItem
        task = tasks[indexPath.row]
        
        if task.task != nil {
            if !tasks[indexPath.row].isComplete() {
                cell!.textLabel?.text = "To do - " + task.task!
            }
        }
        
//        if imageCache.objectForKey(indexPath.row) != nil {
//            // no need to download, just get from cache!
//        } else {
//            // add to cache and request download
//            imageCache.setObject(image, key: indexPath.row)
//        }
        
        
        cell?.backgroundColor = UIColor.whiteColor()
        if task.isComplete() {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell?.textLabel?.textColor = UIColor.blueColor()
        } else {
            cell?.accessoryType = UITableViewCellAccessoryType.None
            cell?.textLabel?.textColor = UIColor.redColor()
        }
        
//        cell?.textLabel?.textColor = UIColor.blackColor()
        return cell!
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !self.tasks[indexPath.row].isComplete() {
            self.tasks[indexPath.row].complete = true
            let text = self.tasks[indexPath.row].task as String?
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.textLabel?.text = "Completed - " + text!
            self.tasks[indexPath.row].complete = true
            UIView.animateWithDuration(2.0) {
                tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
                
            }
        } else {
            
            let text = self.tasks[indexPath.row].task as String?
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.textLabel?.text = "To Do - " + text!
            self.tasks[indexPath.row].complete = false
            UIView.animateWithDuration(2.0) {
                tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
                
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        refresh()
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tasks.removeAtIndex(indexPath.row)
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
//    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
//        <#code#>
//    }

    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "stats" {
//            let nav = segue.destinationViewController as! UINavigationController
            let targetVC = segue.destinationViewController as! DailyStatsViewController
            targetVC.tasks = self.tasksComplete()
        }
        
        if segue.identifier == "add" {
            //            let nav = segue.destinationViewController as! UINavigationController
            
            let targetVC = segue.destinationViewController as! ToDoItemViewController
            targetVC.tasks = self.tasks
            targetVC.delegate = self
        }
    }
    
    
    func add(item: ToDoItem) {
        if (self.tableView.separatorStyle == UITableViewCellSeparatorStyle.None) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            self.label.text = ""
            self.tableView.backgroundColor = UIColor.darkGrayColor()
        }
        tasks.append(item)
        refresh()
    }
  

    
}
