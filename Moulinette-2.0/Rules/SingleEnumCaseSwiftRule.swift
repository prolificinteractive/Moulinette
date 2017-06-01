//
//  SingleEnumCaseSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class SingleEnumCaseSwiftRule: SwiftRule {
    
    let name: String = "Enums (one case statement per line)"
    
    private var projectData: ProjectData
    private var failedString = ""
    
    fileprivate var contextCheck = ContextCheck()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> GradeType {
        for (fileName, fileComponents) in projectData.applicationComponents {
            fileComponents.forEach {
                contextCheck.check(fileLine: $0)
                
                if contextCheck.currentContext == .enumContext, $0.contains("case ") && $0.contains(",") {
                    failedString += formattedFailedString(fileName: fileName, fileLine: $0)
                }
            }
        }
        return (failedString == "") ? .pass : .fail(failedString)
    }
}
