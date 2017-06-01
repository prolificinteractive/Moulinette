//
//  ColorEncapsulationSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class ColorEncapsulationSwiftRule: SwiftRule {
    
    let name: String = "Color Encapsulation"
    
    private var projectData: ProjectData
    private var failedString = ""
    
    private var colorCount = 0
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> GradeType {
        for (fileName, fileComponents) in projectData.applicationComponents {
            var fileContainsColor = false
            fileComponents.forEach {
                if $0.contains("UIColor.") {
                    fileContainsColor = true
                    failedString += formattedFailedString(fileName: fileName, fileLine: $0)
                }
            }
            
            if fileContainsColor {
                colorCount += 1
            }
        }
        
        if colorCount <= 1 {
            failedString = ""
        }
        return (failedString == "") ? .pass : .fail(failedString)
    }
}
