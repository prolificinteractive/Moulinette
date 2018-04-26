//
//  InternalModifierSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class InternalModifierSwiftRule: SwiftRule {
    
    let description: String = "Access modifiers used for all top level declarations EXCEPT Internal"
    let nameId = "top_access_modifier"

    let priority: RulePriority = .low
        
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.swiftFiles {
            fileComponents.forEach {
                if $0.contains("internal ") && !$0.isComment() {
                    auditGrader.violationFound(fileName: fileName, lineNumber: fileComponents.lineNumberFor($0), description: description, nameId: nameId)
                }
            }
        }
        return auditGrader.generateGrade()
    }
}
