//
//  TypeInferenceSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class TypeInferenceSwiftRule: SwiftRule {
    
    let name: String = "Unnecessary Type inference"
    
    private var projectData: ProjectData
    private var failedString = ""
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> GradeType {
        for (fileName, fileComponents) in projectData.applicationComponents {
            fileComponents.forEach {
                if unnecessaryTypeInference(fileLine: $0) {
                    failedString += formattedFailedString(fileName: fileName, fileLine: $0)
                }
            }
        }
        return (failedString == "") ? .pass : .fail(failedString)
    }
}

private extension TypeInferenceSwiftRule {
    
    func unnecessaryTypeInference(fileLine: String) -> Bool {
        let noSpacefileLine = fileLine.stringWithoutWhitespaces()
        if (fileLine.contains("let") || fileLine.contains("var")),
            let type = noSpacefileLine.stringBetween(startString: ":", endString: "="),
            let classInit = noSpacefileLine.stringBetween(startString: "=", endString: "("),
            type == classInit {
            return true
        }
        return false
    }
}
