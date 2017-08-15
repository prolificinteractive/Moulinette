//
//  TestCoverageSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Adam Tecle on 8/15/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Defines rule that a project should have x% test coverage
final class TestCoverageSwiftRule: SwiftRule {

    // MARK: - Public

    let name: String = "Project should have " + String(format: "%.0f", requiredCoveragePercentage * 100) + "% test coverage"
    let priority: RulePriority = .medium

    // MARK: - Private

    private var projectData: ProjectData
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    private static let requiredCoveragePercentage = 0.1

    init(projectData: ProjectData) {
        self.projectData = projectData
    }

    func run() -> AuditGrade {

        return auditGrader.generateGrade()
    }

}
