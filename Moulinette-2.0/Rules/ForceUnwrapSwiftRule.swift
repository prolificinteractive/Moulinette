//
//  ForceUnwrapSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class ForceUnwrapSwiftRule: SwiftRule {
    
    let name: String = "Limited use of forced unwrap (including casting, excluding test target)"
    let priority: RulePriority = .high
    
    private var projectData: ProjectData
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents {
            fileComponents.forEach {
                if $0.contains("!") && !$0.contains("IBOutlet") && !$0.contains("!=") && !$0.contains(" !") {
                    auditGrader.violationFound(fileName: fileName, description: $0)
                }
            }
        }
        return auditGrader.generateGrade()
    }
}
