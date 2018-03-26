//
//  WeakIBOutletSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class WeakIBOutletSwiftRule: SwiftRule {
    
    let name: String = "IBOutlet marked as weak and private (except IBOutletCollection)"
    let priority: RulePriority = .high
    
    private var projectData: ProjectData
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                if $0.contains("IBOutlet") && !$0.contains("weak") && !$0.contains("IBOutletCollection") {
                    auditGrader.violationFound(fileName: fileName, lineNumber: fileComponents.index(of: $0), description: name)
                }
            }
        }
        return auditGrader.generateGrade()
    }
}
