//
//  SwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/30/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

protocol SwiftRule {
    
    var name: String { get }
    
    func run() -> GradeType
}

extension SwiftRule {
    
    func formattedFailedString(fileName: String, fileLine: String) -> String {
        return fileName + "\n" + fileLine + "\n"
    }
}
