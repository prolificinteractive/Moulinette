//
//  SemiColonSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class SemiColonSwiftRule: SwiftRule {
    
    let name: String = "No use of ; (semi colon)"
    
    let priority: RulePriority = .low
    
    private var projectData: ProjectData
    private var failedString = ""
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> GradeType {
        for (fileName, fileComponents) in projectData.applicationComponents {
            fileComponents.forEach {
                if $0.characters.last == ";" {
                    failedString += formattedFailedString(fileName: fileName, fileLine: $0)
                }
            }
        }
        
        return (failedString == "") ? .pass : .fail(failedString)
    }
}
