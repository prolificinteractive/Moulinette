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

    private var violationCount = 0
    private var violations = [Violation]()
    private var failedString = ""
    
    init(priority: RulePriority) {
        self.priority = priority
    }
    
    func violationFound(fileName: String, lineNumber: Int?, description: String) {
        violations.append(Violation(fileName: fileName, lineNumber: lineNumber, description: description))
        violationCount = violations.count
        failedString += formattedFailedString(fileName: fileName, description: description)
    }
    
    func generateGrade() -> AuditGrade {
        let grade: GradeType = (failedString.isEmpty) ? .pass : .fail(failedString)
        return AuditGrade(gradeType: grade,
                          priority: priority,
                          violationCount: violationCount,
                          violationDescription: failedString,
                          violations: violations)
    }
    
    func failed(fileName: String, description: String) {
        violations.append(Violation(fileName: fileName, lineNumber: nil, description: description))
        violationCount = Int.max
        failedString += formattedFailedString(fileName: fileName, description: description)
    }
}

private extension PIOSAuditGrader {
    
    func formattedFailedString(fileName: String, description: String) -> String {
        return fileName + ": " + description + "\n"
    }
}
