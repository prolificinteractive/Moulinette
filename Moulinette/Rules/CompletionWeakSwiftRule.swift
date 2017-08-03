//
//  CompletionWeakSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/8/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class CompletionWeakSwiftRule: SwiftRule {
    
    let name: String = "Weak Self Completion Closure"
    
    let priority: RulePriority = .high
    
    private var projectData: ProjectData
    private var contextCheck = ContextCheck()
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            contextCheck.lineContextDict = [:]
            fileComponents.forEach {
                if contextCheck.currentContext == .completion, $0.contains("self"),
                    contextCheck.lineContextDict[.structContext] == nil {
                    auditGrader.violationFound(fileName: fileName, description: $0)
                }
                
                contextCheck.check(fileLine: $0)
            }
        }
        return auditGrader.generateGrade()
    }
}
