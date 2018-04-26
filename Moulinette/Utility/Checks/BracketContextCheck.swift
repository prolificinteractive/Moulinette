//
//  BracketContextCheck.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

class BracketContextCheck: Check {
    
    var bracketsArray = [String]()
    var lineContext: LineContext

    init(lineContext: LineContext) {
        self.lineContext = lineContext
    }
    
    func check(fileLine: String) {
        if fileLine.contains("{") {
            bracketsArray.append(fileLine)
        } else if fileLine.contains("}") {
            _ = bracketsArray.removeFirst()
        }
    }
}
