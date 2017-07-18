//
//  SinglePublicInternalSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class SinglePublicInternalSwiftRule: SwiftRule {
    
    let name: String = "One public/internal type per file (class, enum, protocol, struct)"
    
    let priority: RulePriority = .low
    
    private var projectData: ProjectData
    private var failedString = ""
    private var type: FileType?
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                if let fileType = FileType.type(fileLine: $0) {
                    if type != nil {
                        auditGrader.violationFound(fileName: fileName, description: $0)
                    }
                    type = fileType
                }
            }
            type = nil
        }
        return auditGrader.generateGrade()
    }
}
