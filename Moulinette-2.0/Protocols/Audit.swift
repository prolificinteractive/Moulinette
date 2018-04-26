//
//  Audit.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Contains a collection of rules for the audit and the ability to run them.
protocol Audit {
    
    /// Runs the rules for a particular audit.
    ///
    /// - Returns: Formatted output for the given audit.
    func runRules() -> Output
}
