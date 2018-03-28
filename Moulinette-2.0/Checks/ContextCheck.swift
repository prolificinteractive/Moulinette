//
//  ContextCheck.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

class ContextCheck: Check {
    
    /// Current context of the line.
    var currentContext: LineContext {
        return lineContextArray.last?.lineContext ?? .none
    }

    var lineContextArray = [BracketContextCheck]()

    func check(fileLine: String) {
        if let contextType = LineContext.type(fileLine: fileLine) {
            lineContextArray.append(BracketContextCheck(lineContext: contextType))
        }

        checkLineContext(contextType: currentContext, fileLine: fileLine)
    }
    
    /// Checks if the line context is found in the current list of contexts.
    ///
    /// - Parameter type: Type to check for.
    /// - Returns: Flag to determine if the rule is within a current context.
    func insideContext(type: LineContext) -> Bool {
        for context in lineContextArray {
            if context.lineContext == type {
                return true
            }
        }
        return false
    }

    /// Resets the current context.
    func resetContext() {
        lineContextArray = []
    }
}

private extension ContextCheck {
    
    func checkLineContext(contextType: LineContext, fileLine: String) {
        lineContextArray.last?.check(fileLine: fileLine)

        if lineContextArray.last?.bracketsArray.isEmpty ?? false {
            _ = lineContextArray.popLast()
        }
    }
}
