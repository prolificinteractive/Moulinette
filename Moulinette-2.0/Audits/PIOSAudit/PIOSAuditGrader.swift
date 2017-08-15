//
//  PIOSAuditGrader.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Grader for the PiOS Audit.
final class PIOSAuditGrader: AuditGrader {
    
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
    
    func failed(fileName: String, description: String) {
        violations = Int.max
        failedString += formattedFailedString(fileName: fileName, description: description)
    }
}

private extension PIOSAuditGrader {
    
    func formattedFailedString(fileName: String, description: String) -> String {
        return fileName + "\n" + description + "\n"
    }
}
