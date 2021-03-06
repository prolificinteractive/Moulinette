//
//  RulePriority.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/8/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

enum RulePriority {
    case critial
    case high
    case medium
    case low
    
    /// Score calculation with the given parameters.
    ///
    /// - Parameter violations: Number of violations found
    /// - Returns: Updated score with weight and violations taken into consideration.
    func score(violations: Int) -> Double {
        let wt = weight()
        let score = wt * (wt / (Double(violations) + wt))
        return round(score * 100) / 100
    }
    
    /// Weight of the rule priority.
    ///
    /// - Returns: Weight of the rule priority.
    func weight() -> Double {
        switch self {
        case .critial:
            return 10
        case .high:
            return 7
        case .medium:
            return 5
        case .low:
            return 3
        }
    }
}
