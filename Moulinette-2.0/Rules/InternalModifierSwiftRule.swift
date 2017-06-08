//
//  InternalModifierSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class InternalModifierSwiftRule: SwiftRule {
    
    let name: String = "Access modifiers used for all top level declarations EXCEPT Internal"
    
    let priority: RulePriority = .low
    
    private var projectData: ProjectData
    private var failedString = ""
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> GradeType {
        for (fileName, fileComponents) in projectData.applicationComponents {
            fileComponents.forEach {
                if $0.contains("internal ") {
                    failedString += formattedFailedString(fileName: fileName, fileLine: $0)
                }
            }
        }
        return (failedString == "") ? .pass : .fail(failedString)
    }
}
