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
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            var todoCount = 0
            CommentParser.parse(fileComponents: fileComponents) { (comment, line) in
                todoCount = comment.isTodoComment() ? todoCount + 1 : todoCount
                if todoCount > 10 {
                    auditGrader.violationFound(fileName: fileName, description: line)
                }
            }
        }

        return auditGrader.generateGrade()
    }

}
