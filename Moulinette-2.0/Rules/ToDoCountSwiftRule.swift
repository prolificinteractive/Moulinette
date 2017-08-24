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

    private let projectData: ProjectData
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    init(projectData: ProjectData) {
        self.projectData = projectData
    }

    func run() -> AuditGrade {
        var todoCount = 0
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                todoCount = $0.isTodoComment() ? todoCount + 1 : todoCount
                if todoCount > ToDoCountSwiftRule.maxTodoCount {
                    auditGrader.violationFound(fileName: fileName, description: $0)
                }
            }
        }

        return auditGrader.generateGrade()
    }

}
