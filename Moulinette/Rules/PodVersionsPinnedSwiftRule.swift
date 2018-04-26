//
//  PodVersionsPinnedSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Adam Tecle on 6/26/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Checks that every CocoaPod is pinned to a version.
final class PodVersionsPinnedSwiftRule: SwiftRule {

    let name: String = "All pods should be pinned to a version"
    let priority: RulePriority = .high

    private var projectData: ProjectData
    private let fileName = "Podfile"

    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    init(projectData: ProjectData) {
        self.projectData = projectData
    }

    func run() -> AuditGrade {
        guard let podfile = projectData.applicationComponents.file(by: fileName) else {
            auditGrader.failed(fileName: fileName, description: "Couldn't find Podfile")
            return auditGrader.generateGrade()
        }

        PodfileParser.parse(podfile) { [unowned self] tokens, line in
            let noVersionSpecified = tokens.count <= 2
            let usesComparisonOperators = !noVersionSpecified && (tokens[2].contains("<") || tokens[2].contains(">"))
            let specifiesGitRepo = !noVersionSpecified && tokens[2].contains(":git")
            let specifiesGitTag = !noVersionSpecified && tokens.contains { $0.contains(":tag") }
            if noVersionSpecified {
                self.auditGrader.violationFound(fileName: self.fileName, description: line)
            } else if usesComparisonOperators {
                self.auditGrader.violationFound(fileName: self.fileName, description: line)
            } else if specifiesGitRepo && !specifiesGitTag {
                self.auditGrader.violationFound(fileName: self.fileName, description: line)
            }
        }

        return auditGrader.generateGrade()
    }

}
