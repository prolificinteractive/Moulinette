//
//  ToDoCountSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Adam Tecle on 6/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Defines rule that every comment with a TODO should have a pivotal story linked
final class ToDoCountSwiftRule: SwiftRule {

    /// Max TODO count acceptable.
    static let maxTodoCount = 10

    let name: String = "There should be less than 10 TODOs"
    let priority: RulePriority = .medium

    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    func run(projectData: ProjectData) -> AuditGrade {
        let swiftFiles = projectData.applicationComponents.swiftFiles
        let allContents = projectData.applicationComponents.mergeContents(files: swiftFiles).uppercased()
        
        let count = allContents.components(separatedBy: "TODO").count - 1
        if count > ToDoCountSwiftRule.maxTodoCount {
            auditGrader.failed(description: "More than \(ToDoCountSwiftRule.maxTodoCount) found. (\(count) found.)")
        }
        
        return auditGrader.generateGrade()
    }

}
