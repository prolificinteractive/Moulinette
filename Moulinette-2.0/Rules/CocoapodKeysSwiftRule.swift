//
//  CocoapodKeysSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Checks if the project's organization includes the given default folders.
final class CocoapodsKeysSwiftRule: SwiftRule {
    
    let name: String = "Cocoapods Keys Used"
    let priority: RulePriority = .high
    
    private var projectData: ProjectData
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        for (_, fileComponents) in projectData.applicationComponents.components {
            for component in fileComponents {
                if component.contains("import Keys") {
                    return auditGrader.generateGrade()
                }
            }
        }
        // Check pod file
        
        auditGrader.failed(description: "Cocoapods Keys Import Not Found!")
        return auditGrader.generateGrade()
    }
}
