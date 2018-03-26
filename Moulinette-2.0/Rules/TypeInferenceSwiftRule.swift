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
    let priority: RulePriority = .medium
    
    private var projectData: ProjectData
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                if unnecessaryTypeInference(fileLine: $0) {
                    auditGrader.violationFound(fileName: fileName, lineNumber: fileComponents.index(of: $0), description: $0)
                }
            }
        }
        return auditGrader.generateGrade()
    }
}

private extension TypeInferenceSwiftRule {
    
    func unnecessaryTypeInference(fileLine: String) -> Bool {
        let noSpacefileLine = fileLine.stringWithoutWhitespaces()
        
        guard (fileLine.contains("let") || fileLine.contains("var")),
            let type = noSpacefileLine.stringBetween(startString: ":", endString: "=") else {
                return false
        }
        
        return primitiveTypeInference(noSpacefileLine: noSpacefileLine, type: type) ||
            customTypeInference(noSpacefileLine: noSpacefileLine, type: type)
    }
    
    private func customTypeInference(noSpacefileLine: String, type: String) -> Bool {
        if let classInit = noSpacefileLine.stringBetween(startString: "=", endString: "("),
            type == classInit {
            return true
        }
        return false
    }
    
    private func primitiveTypeInference(noSpacefileLine: String, type: String) -> Bool {
        guard let startRange = noSpacefileLine.range(of: "=") else {
            return false
        }
        
        let range = Range(uncheckedBounds: (lower: startRange.upperBound, upper: noSpacefileLine.endIndex))
        let classInit = noSpacefileLine.substring(with: range)
        if (type == "String" && classInit == "\"\"") {
            return true
        }
        return false
    }
}
