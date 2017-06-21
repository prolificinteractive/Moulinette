//
//  AuditGrade.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct AuditGrade {
    var gradeType: GradeType
    var priority: RulePriority
    var violations: Int
    
    func score() -> Double {
        return priority.score(violations: violations)
    }
}
