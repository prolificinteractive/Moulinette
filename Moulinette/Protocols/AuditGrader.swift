//
//  AuditGrader.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Audit grader protocol used to grade a rule.
protocol AuditGrader {

    var violations: [Violation] { get }
    
    /// Increments the number of violations with the given parameters.
    ///
    /// - Parameters:
    ///   - fileName: File name of the violation.
    ///   - description: Desciption of the violation.
    ///   - nameId: Name id of the rule violated.
    func violationFound(fileName: String, lineNumber: Int?, description: String, nameId: String)

    /// Generates the audit grade for the rule.
    ///
    /// - Returns: Grade for the current rule.
    func generateGrade() -> AuditGrade
    
    /// Called when a project has failed the rule. No partial points will be given.
    ///
    /// - Parameters:
    ///   - fileName: File name of the location of the violation.
    ///   - description: Reason why the rule failed.
    ///   - nameId: Name id of the rule violated.
    func failed(fileName: String, description: String, nameId: String)
}

extension AuditGrader {
    
    /// Called when a project has failed the rule with a default file name error.
    ///
    /// - Parameter description: Reason why the rule failed.
    func failed(description: String, nameId: String) {
        failed(fileName: "Project Failed", description: description, nameId: nameId)
    }
}
