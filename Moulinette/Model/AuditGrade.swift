//
//  AuditGrade.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Audit grade.
struct AuditGrade {
   
    /// Grade type.
    var gradeType: GradeType
    
    /// Priority,
    var priority: RulePriority
    
    /// Number of violations.
    var violations: Int
    
    /// Violation description text.
    var violationDescription: String
    
    func score() -> Double {
        return priority.score(violations: violations)
    }
    
}
