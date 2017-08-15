//
//  AuditGrader.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Audit grader protocol used to grade a rule.
protocol AuditGrader {
    
    /// Increments the number of violations with the given parameters.
    ///
    /// - Parameters:
    ///   - fileName: File name of the violation.
    ///   - description: Desciption of the violation.
    func violationFound(fileName: String, description: String)
    
    /// Generates the audit grade for the rule.
    ///
    /// - Returns: Grade for the current rule.
    func generateGrade() -> AuditGrade
    
    /// Called when a project has failed the rule. No partial points will be given.
    ///
    /// - Parameters:
    ///   - fileName: File name of the location of the violation.
    ///   - description: Reason why the rule failed.
    func failed(fileName: String, description: String)
}
