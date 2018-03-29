//
//  CocoapodKeysSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Checks if cocoapods keys are imported in the project.
final class CocoapodsKeysSwiftRule: SwiftRule {
    
    let name: String = "Cocoapods Keys Used"
    let priority: RulePriority = .high
        
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        guard !projectData.applicationComponents.components.isEmpty else {
            return auditGrader.generateGrade()
        }
        
        for (_, fileComponents) in projectData.applicationComponents.components {
            for component in fileComponents {
                if component.contains("import Keys") {
                    return auditGrader.generateGrade()
                }
            }
        }
        
        auditGrader.failed(description: "Cocoapods Keys Import Not Found!")
        return auditGrader.generateGrade()
    }
}
