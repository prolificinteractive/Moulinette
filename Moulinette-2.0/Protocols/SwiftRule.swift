//
//  SwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/30/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Swift rule protocol used as a template for all rules of the audit.
protocol SwiftRule {
    
    /// Default initialization of a swift rule.
    ///
    /// - Parameter projectData: Current project data to parse.
    init(projectData: ProjectData)
    
    /// Name of the rule.
    var name: String { get }
    
    /// Priority of the current rule.
    var priority: RulePriority { get }
    
    /// Run the swift rule.
    ///
    /// - Returns: An audit grade to parse.
    func run() -> AuditGrade
}

extension SwiftRule {
    
    /// Default formatting for a failed string.
    ///
    /// - Parameters:
    ///   - fileName: File name location of the violation.
    ///   - fileLine: File line of the violation.
    /// - Returns: Formatted string.
    func formattedFailedString(fileName: String, fileLine: String) -> String {
        return fileName + "\n" + fileLine + "\n"
    }
}

protocol CorrectableSwiftRule: SwiftRule {

    func correct() -> ProjectComponents
}
