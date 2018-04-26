//
//  PodVersionsPinnedSwiftRule.swift
//  Moulinette
//
//  Created by Adam Tecle on 6/26/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Checks that every CocoaPod is pinned to a version.
final class PodVersionsPinnedSwiftRule: SwiftRule {

    let description = "All pods should be pinned to a version"
    let nameId = "pods_version_pinned"

    let priority: RulePriority = .high

    private let fileName = "Podfile"

    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    func run(projectData: ProjectData) -> AuditGrade {
        guard let podfile = projectData.applicationComponents.file(by: fileName) else {
            auditGrader.failed(fileName: fileName, description: "Couldn't find Podfile", nameId: nameId)
            return auditGrader.generateGrade()
        }

        PodfileParser.parse(podfile) { [unowned self] tokens, line, lineNumber in
            let noVersionSpecified = tokens.count <= 2
            let usesComparisonOperators = !noVersionSpecified && (tokens[2].contains("<") || tokens[2].contains(">"))
            let specifiesGitRepo = !noVersionSpecified && tokens[2].contains(":git")
            let specifiesGitTag = !noVersionSpecified && tokens.contains { $0.contains(":tag") }
            if noVersionSpecified {
                self.auditGrader.violationFound(fileName: self.fileName, lineNumber: lineNumber, description: line, nameId: self.nameId)
            } else if usesComparisonOperators {
                self.auditGrader.violationFound(fileName: self.fileName, lineNumber: lineNumber, description: line, nameId: self.nameId)
            } else if specifiesGitRepo && !specifiesGitTag {
                self.auditGrader.violationFound(fileName: self.fileName, lineNumber: lineNumber, description: line, nameId: self.nameId)
            }
        }

        return auditGrader.generateGrade()
    }

}
