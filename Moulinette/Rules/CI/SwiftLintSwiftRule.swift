//
//  SwiftLintSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 8/15/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Checks if the SwiftLint build phase script is included in the project's build phase. 
final class SwiftLintSwiftRule: SwiftRule {
    
    let description = "Uses SwiftLint in Project"
    let nameId = "swiftlint_found"

    let priority: RulePriority = .medium
        
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        guard let fileComponents = projectData.applicationComponents.file(by: Constants.FileNameConstants.xcodeProject) else {
            auditGrader.failed(fileName: Constants.FileNameConstants.xcodeProject,
                               description: "Xcode project could not be found!",
                               nameId: nameId)
            return auditGrader.generateGrade()
        }
        
        for component in fileComponents {
            if component.contains("${PODS_ROOT}/SwiftLint/swiftlint") ||
                component.contains("if which swiftlint >/dev/null; then") {
                return auditGrader.generateGrade()
            }
        }

        auditGrader.failed(fileName: Constants.FileNameConstants.xcodeProject,
                           description: "SwiftLint not found in build phase.",
                           nameId: nameId)
        
        return auditGrader.generateGrade()
    }
}
