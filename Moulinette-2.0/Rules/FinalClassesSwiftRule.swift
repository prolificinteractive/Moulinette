//
//  FinalClassesSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class FinalClassesSwiftRule: SwiftRule {
    
    let name: String = "All classes should be final except when subclassed"
    let priority: RulePriority = .high
        
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                if $0.isProjectClass(),
                    !$0.contains("final"),
                    let className = $0.className(),
                    !projectData.subClassFound(className: className) {

                    auditGrader.violationFound(fileName: fileName,
                                               lineNumber: fileComponents.lineNumberFor($0),
                                               description: name)
                }
            }
        }
        return auditGrader.generateGrade()
    }
}
