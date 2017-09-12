//
//  Project.swift
//  Coffee
//
//  Created by Morgan Collino on 9/12/17.
//  Copyright © 2017 Morgan Collino. All rights reserved.
//

import Cocoa

struct Project {

    let identifier: String
    
    let name: String
    
    let silentMode: Bool
    
    let verbose: Bool
    
    let directory: String
    
    static func boolToString(bool: Bool) -> String {
        if bool == true {
            return "true"
        } else {
            return "false"
        }
    }
    
}
