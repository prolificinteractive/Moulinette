//
//  InternalModifierSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class InternalModifierSwiftRule: SwiftRule {
    
    let name: String = "Access modifiers used for all top level declarations EXCEPT Internal"
    let priority: RulePriority = .low
    
    private var projectData: ProjectData
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.swiftFiles {
            fileComponents.forEach {
                if $0.contains("internal ") {
                    auditGrader.violationFound(fileName: fileName, lineNumber: fileComponents.index(of: $0), description: name)
                }
            }
        }
        return auditGrader.generateGrade()
    }
}
