//
//  FontEncapsulationSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class FontEncapsulationSwiftRule: SwiftRule {
    
    let name: String = "Font Encapsulation"
    let priority: RulePriority = .medium
    
    private var failedString = ""
    private var fontCount = 0
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            var fileContainsFont = false
            fileComponents.forEach {
                if $0.contains("UIFont.") && fontCount >= 1  {
                    fileContainsFont = true
                    auditGrader.violationFound(fileName: fileName,
                                               lineNumber: fileComponents.lineNumberFor($0),
                                               description: name)
                }
            }
            
            if fileContainsFont {
                fontCount += 1
            }
        }
        return auditGrader.generateGrade()
    }
}
