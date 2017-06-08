//
//  FinalClassesSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class FinalClassesSwiftRule: SwiftRule {
    
    let name: String = "All classes should be final except when subclassed"
    
    let priority: RulePriority = .high
    
    private var projectData: ProjectData
    private var failedString = ""
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> GradeType {
        for (fileName, fileComponents) in projectData.applicationComponents {
            fileComponents.forEach {
                if $0.isProjectClass(),
                    !$0.contains("final"),
                    let className = $0.className(),
                    !projectData.subClassFound(className: className) {
                    
                    failedString += formattedFailedString(fileName: fileName, fileLine: $0)
                }
            }
        }
        return (failedString == "") ? .pass : .fail(failedString)
    }
}
