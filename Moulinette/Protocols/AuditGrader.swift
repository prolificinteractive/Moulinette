//
//  AuditGrader.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Audit grader.
protocol AuditGrader {
    
    /// Violation found.
    ///
    /// - Parameters:
    ///   - fileName: File name text.
    ///   - description: Description text.
    func violationFound(fileName: String, description: String)
    
    /// Generate grade.
    ///
    /// - Returns: Object following Audit grade protocol.
    func generateGrade() -> AuditGrade
    
    /// Failed.
    ///
    /// - Parameters:
    ///   - fileName: File name text.
    ///   - description: Description text.
    func failed(fileName: String, description: String)
}
