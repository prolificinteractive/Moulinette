//
//  AppIconSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Checks if there is an app icon associated with each build configuration.
final class AppIconSwiftRule: SwiftRule {
    
    let description = "App Icon for Build Configurations"
    let nameId = "app_icon"
    
    let priority: RulePriority = .high
        
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    func run(projectData: ProjectData) -> AuditGrade {
        guard let fileComponents = projectData.applicationComponents.file(by: Constants.FileNameConstants.xcodeProject) else {
            auditGrader.failed(fileName: Constants.FileNameConstants.xcodeProject,
                               description: "Xcode project could not be found!", nameId: nameId)
            return auditGrader.generateGrade()
        }
        
        for component in fileComponents {
            if component.contains("ASSETCATALOG_COMPILER_APPICON_NAME") && component.contains(" = \"\"") {
                auditGrader.violationFound(fileName: Constants.FileNameConstants.xcodeProject, lineNumber: nil, description: component, nameId: nameId)
            }
        }

        return auditGrader.generateGrade()
    }
}

