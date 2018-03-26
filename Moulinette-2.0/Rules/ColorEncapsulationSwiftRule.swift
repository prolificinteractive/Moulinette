//
//  ColorEncapsulationSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class ColorEncapsulationSwiftRule: SwiftRule {
    
    let name: String = "Color Encapsulation"
    let priority: RulePriority = .medium
    
    private var projectData: ProjectData
    private var colorCount = 0
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            var fileContainsColor = false
            fileComponents.forEach {
                if $0.contains("UIColor.") && colorCount >= 1 {
                    fileContainsColor = true
                    auditGrader.violationFound(fileName: fileName, lineNumber: fileComponents.index(of: $0), description: name)
                }
            }
            
            if fileContainsColor {
                colorCount += 1
            }
        }
        return auditGrader.generateGrade()
    }
}
