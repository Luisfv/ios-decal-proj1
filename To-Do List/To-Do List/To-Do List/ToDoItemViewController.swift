//
//  ToDoItemViewController.swift
//  To-Do List
//
//  Created by Luis Vasquez on 10/9/15.
//  Copyright © 2015 Luis Vasquez. All rights reserved.
//

import UIKit

protocol MyProtocol
{
    func add(item: ToDoItem)
}


class ToDoItemViewController: UIViewController, UITextFieldDelegate {
    
    var tasks = [ToDoItem]()
    var delegate:MyProtocol?


    @IBOutlet weak var task: UITextField!
    
    @IBAction func addTask(sender: AnyObject) {
        let item = ToDoItem(task: task.text!, complete: false)
        delegate?.add(item)
        navigationController?.popViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addTasks")
//        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.grayColor()
//        
//        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backToList")
//        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.grayColor()
//        
        task.becomeFirstResponder()
        task.delegate = self
        self.navigationItem.title = "Task"
        
        self.view.backgroundColor = UIColor.darkGrayColor()
        
    }
    
    func backToList() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func add(item: ToDoItem) {
        navigationController?.popViewControllerAnimated(true)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
