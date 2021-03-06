//
//  ToDoStorySwiftRule.swift
//  Moulinette
//
//  Created by Adam Tecle on 6/15/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Defines rule that every comment with a TODO should have a pivotal story linked
final class ToDoStorySwiftRule: SwiftRule {

    let description = "Every TODO comment should have a link to a story in Pivotal"
    let nameId = "todo_story_link"

    let priority: RulePriority = .medium

    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            CommentParser.parse(fileComponents: fileComponents) { (comment, line, lineNumber) in
                if comment.isTodoComment() && !comment.hasPivotalStory() {
                    auditGrader.violationFound(fileName: fileName,
                                               lineNumber: lineNumber,
                                               description: "Missing story for comment: '\(comment)'.",
                                               nameId: nameId)
                }
            }
        }

        return auditGrader.generateGrade()
    }

}
