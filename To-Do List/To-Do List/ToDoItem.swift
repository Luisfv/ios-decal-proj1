//
//  ToDoItem.swift
//  To-Do List
//
//  Created by Luis Vasquez on 10/9/15.
//  Copyright © 2015 Luis Vasquez. All rights reserved.
//

import Foundation

struct ToDoItem {
    let task : String?
    
    var complete : Bool = false
    
    func isComplete() -> Bool {
        return complete
    }
}