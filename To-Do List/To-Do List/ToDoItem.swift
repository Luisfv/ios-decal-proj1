//
//  ToDoItem.swift
//  To-Do List
//
//  Created by Luis Vasquez on 10/9/15.
//  Copyright © 2015 Luis Vasquez. All rights reserved.
//

import Foundation

struct ToDoItem: Equatable {
    let task : String?
    
    var complete : Bool = false
    
    let start = NSDate().dateByAddingTimeInterval(60*60*24)
    
    func isComplete() -> Bool {
        return complete
    }
    
    func isExpired() -> Bool {
        if start.timeIntervalSinceNow < 0 {
            return true
        } else {
            return false
        }
    }
}

func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
    return lhs.task == rhs.task && lhs.start == rhs.start
}