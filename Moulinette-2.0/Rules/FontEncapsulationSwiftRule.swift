//
//  FontEncapsulationSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class FontEncapsulationSwiftRule: SwiftRule {
    
    let name: String = "Font Encapsulation"
    
    let priority: RulePriority = .medium
    
    private var projectData: ProjectData
    private var failedString = ""
    
    private var fontCount = 0
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> GradeType {
        for (fileName, fileComponents) in projectData.applicationComponents {
            var fileContainsFont = false
            fileComponents.forEach {
                if $0.contains("UIFont.") {
                    fileContainsFont = true
                    failedString += formattedFailedString(fileName: fileName, fileLine: $0)
                }
            }
            
            if fileContainsFont {
                fontCount += 1
            }
        }
        
        if fontCount <= 1 {
            failedString = ""
        }
        return (failedString == "") ? .pass : .fail(failedString)
    }
}
