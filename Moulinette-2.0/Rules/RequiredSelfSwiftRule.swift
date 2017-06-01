//
//  RequiredSelfSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class RequiredSelfSwiftRule: SwiftRule {
    
    let name: String = "Use of self only when required"
    
    private var projectData: ProjectData
    
    fileprivate var contextCheck = ContextCheck()
    
    var count = 0
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> GradeType {
        for (fileName, fileComponents) in projectData.applicationComponents {
            fileComponents.forEach {
                contextCheck.check(fileLine: $0)
                
                if variableSetCheck(fileLine: $0, fileName: fileName) {
                    
                }
                // Check function self
            }
        }
        print(count)
        return .pass
    }
}

private extension RequiredSelfSwiftRule {
    
    func variableSetCheck(fileLine: String, fileName: String) -> Bool {
        guard validContext() else {
            return true
        }
        
        if fileLine.contains("self.") {
            let line = fileLine.replacingOccurrences(of: "self.", with: "")
            
            if let splitString = line.split(at: " = "), !splitString.rightString.contains(splitString.leftString) {
                print(fileName)
                print(fileLine + "\n")
                count += 1
            }
        }
        return true
    }
    
    func validContext() -> Bool {
        if contextCheck.currentContext == .lazy || contextCheck.currentContext == .dispatchMain {
            return false
        }
        return true
    }
    
    // ** REMEMBER FUNCTION CONTEXT **
}
