//
//  DailyStatsViewController.swift
//  To-Do List
//
//  Created by Luis Vasquez on 10/9/15.
//  Copyright © 2015 Luis Vasquez. All rights reserved.
//

import UIKit

class DailyStatsViewController: UIViewController {

    var tasks : Int = 0

    @IBOutlet weak var stats: UILabel!
    
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stats.text = String(tasks)
        
        if tasks == 1 {
            message.text = "task completed in the past 24 hours"
        } else {
            message.text = "tasks completed in the past 24 hours"
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
