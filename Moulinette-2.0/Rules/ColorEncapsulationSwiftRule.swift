//
//  ColorEncapsulationSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class ColorEncapsulationSwiftRule: SwiftRule {
    
    let description: String = "Color Encapsulation"
    let nameId = "color_encapsulation"

    let priority: RulePriority = .medium
    
    private var colorCount = 0
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            var fileContainsColor = false
            fileComponents.forEach {
                if $0.contains("UIColor.") && colorCount >= 1 {
                    fileContainsColor = true
                    auditGrader.violationFound(fileName: fileName, lineNumber: fileComponents.lineNumberFor($0), description: description, nameId: nameId)
                }
            }
            
            if fileContainsColor {
                colorCount += 1
            }
        }
        return auditGrader.generateGrade()
    }
}
