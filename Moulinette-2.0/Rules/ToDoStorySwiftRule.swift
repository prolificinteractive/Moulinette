//
//  ToDoStorySwiftRule.swift
//  Moulinette-2.0
//
//  Created by Adam Tecle on 6/15/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Defines rule that every comment with a TODO should have a pivotal story linked
final class ToDoStorySwiftRule: SwiftRule {

    let name: String = "Every TODO comment should have a link to a story in Pivotal"
    let priority: RulePriority = .medium

    private let projectData: ProjectData
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    init(projectData: ProjectData) {
        self.projectData = projectData
    }

    func run() -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents {
            CommentParser.parse(fileComponents: fileComponents) { (comment, line) in
                if comment.isTodoComment() && !comment.hasPivotalStory() {
                    auditGrader.violationFound(fileName: fileName, description: line)
                }
            }
        }

        return auditGrader.generateGrade()
    }

}
