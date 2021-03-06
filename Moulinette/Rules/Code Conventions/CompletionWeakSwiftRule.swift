//
//  CompletionWeakSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/8/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class CompletionWeakSwiftRule: SwiftRule {
    
    let description: String = "Weak Self Completion Closure"
    let nameId = "weal_self_completion"

    let priority: RulePriority = .high
    
    private var contextCheck = ContextCheck()
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            contextCheck.resetContext()
            fileComponents.forEach {
                if contextCheck.insideContext(type: .completion) &&
                    $0.contains("self.") &&
                    !contextCheck.insideContext(type: .structContext) {
                    auditGrader.violationFound(fileName: fileName, lineNumber: fileComponents.lineNumberFor($0), description: description, nameId: nameId)
                }
                
                contextCheck.check(fileLine: $0)
            }
        }
        return auditGrader.generateGrade()
    }
}
