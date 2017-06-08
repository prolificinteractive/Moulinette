//
//  MarkUsageSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class MarkUsageSwiftRule: SwiftRule {
    
    let name: String = "Consistent usage of MARK / TODO"
    
    let priority: RulePriority = .low
    
    private var projectData: ProjectData
    private var failedString = ""
        
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> GradeType {
        for (fileName, fileComponents) in projectData.applicationComponents {
            fileComponents.forEach {
                if consistentMark(fileLine: $0) || consistentTodo(fileLine: $0) {
                    failedString += formattedFailedString(fileName: fileName, fileLine: $0)
                }
            }
        }
        return (failedString == "") ? .pass : .fail(failedString)
    }
}

private extension MarkUsageSwiftRule {
    
    func consistentMark(fileLine: String) -> Bool {
        let fileLineUppercase = fileLine.uppercased()
        return fileLineUppercase.contains("//") && fileLineUppercase.contains("MARK ") && !fileLine.contains("// MARK - ")
    }
    
    func consistentTodo(fileLine: String) -> Bool {
        let fileLineUppercase = fileLine.uppercased()
        return fileLineUppercase.contains("//") && fileLineUppercase.contains("TODO ") && !fileLine.contains("// TODO:")
    }
}
