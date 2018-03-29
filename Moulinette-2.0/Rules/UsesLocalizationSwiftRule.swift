//
//  UsesLocalizationSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Adam Tecle on 6/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class UsesLocalizationSwiftRule: SwiftRule {

    let name: String = "Uses Localization"
    let priority: RulePriority = .medium

    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    func run(projectData: ProjectData) -> AuditGrade {
        guard let _ = projectData.applicationComponents.file(by: Constants.FileNameConstants.localizable) else {
            auditGrader.failed(fileName: Constants.FileNameConstants.localizable,
                               description: "No Localizable.strings file found.")
            return auditGrader.generateGrade()
        }

        return auditGrader.generateGrade()
    }
}
