//
//  LineContext.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

enum LineContext {
    case none
    case dispatchMain
    case lazy
    case function
    case enumContext
    
    static func type(fileLine: String) -> LineContext {
        if fileLine.contains("func") {
            return .function
        }
        
        if fileLine.contains("DispatchQueue.main.async") {
            return .dispatchMain
        }
        
        if fileLine.contains("lazy") {
            return .lazy
        }
        
        if fileLine.contains("enum") {
            return .enumContext
        }
        
        return .none
    }
}
