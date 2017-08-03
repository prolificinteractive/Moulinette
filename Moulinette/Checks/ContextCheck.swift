//
//  ContextCheck.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

class ContextCheck: Check {
    
    var lineContextDict: [LineContext : BracketContextCheck] = [:]
    
    var currentContext: LineContext = .none
    
    func check(fileLine: String) {
        let contextType = LineContext.type(fileLine: fileLine)
        
        if contextType != .none {
            currentContext = contextType
            
            if lineContextDict[currentContext] == nil {
                lineContextDict[currentContext] = BracketContextCheck()
            }
        }
        
        checkLineContext(contextType: currentContext, fileLine: fileLine)
    }
}

private extension ContextCheck {
    
    func checkLineContext(contextType: LineContext, fileLine: String) {
        lineContextDict[contextType]?.check(fileLine: fileLine)
        
        if let lineContext = lineContextDict[contextType], lineContext.bracketsArray.isEmpty {
            lineContextDict[contextType] = nil
        }
    }
}
