//
//  SemiColonSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class SemiColonSwiftRule: SwiftRule {
    
    let name: String = "No use of ; (semi colon)"
    let priority: RulePriority = .low
    
    private var projectData: ProjectData
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents {
            fileComponents.forEach {
                if $0.characters.last == ";" {
                    auditGrader.violationFound(fileName: fileName, description: $0)
                }
            }
        }
        return auditGrader.generateGrade()
    }
}


class PIOSAuditGrader: AuditGrader {
    
    let priority: RulePriority
    
    private var violations = 0
    private var failedString = ""
    
    init(priority: RulePriority) {
        self.priority = priority
    }
    
    func violationFound(fileName: String, description: String) {
        violations += 1
        failedString += formattedFailedString(fileName: fileName, description: description)
    }
    
    func generateGrade() -> AuditGrade {
        let grade: GradeType = (failedString.isEmpty) ? .pass : .fail(failedString)
        return AuditGrade(gradeType: grade, priority: priority, violations: violations)
    }
}

private extension PIOSAuditGrader {
    
    func formattedFailedString(fileName: String, description: String) -> String {
        return fileName + "\n" + description + "\n"
    }
}
