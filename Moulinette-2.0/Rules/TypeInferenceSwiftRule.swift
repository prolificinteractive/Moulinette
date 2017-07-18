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
                    auditGrader.violationFound(fileName: fileName, description: $0)
                }
            }
        }
        return auditGrader.generateGrade()
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
