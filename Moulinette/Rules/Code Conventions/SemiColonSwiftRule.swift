//
//  SemiColonSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class SemiColonSwiftRule: SwiftRule {
    
    let description = "No use of ; (semi colon)"
    let nameId = "semi_colon"

    let priority: RulePriority = .low
        
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.swiftFiles {
            fileComponents.forEach {
                if !$0.isComment() && $0.last == ";" {
                    auditGrader.violationFound(fileName: fileName, lineNumber: fileComponents.lineNumberFor($0), description: description, nameId: nameId)
                }
            }
        }
        return auditGrader.generateGrade()
    }
}
