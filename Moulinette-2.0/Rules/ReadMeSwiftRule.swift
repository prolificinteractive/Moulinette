//
//  ReadMeSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Ruchi Jain on 7/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Defines rule for README.md file
final class ReadMeSwiftRule: SwiftRule {
    
    let name: String = "README.md should not contain any TODO items"
    let priority: RulePriority = .low
    
    private let fileName = Constants.FileNameConstants.readme
    
    private var projectData: ProjectData
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        guard let readmeComponents = projectData.applicationComponents.readmeComponents else {
            auditGrader.failed(fileName: fileName, description: "No README found!!!")
            return auditGrader.generateGrade()
        }

        let readMe = readmeComponents.joined(separator: " ")
        
        if hasToDoItems(in: readMe) {
            auditGrader.violationFound(fileName: fileName, lineNumber: nil, description: name)
        }
        
        return auditGrader.generateGrade()
    }
}

private extension ReadMeSwiftRule {
    
    func hasToDoItems(in readMe: String) -> Bool {
        let pattern = "\\sTO DO\\W|\\sTODO\\W"
        let regex = Regex(pattern)
        return regex.hasMatch(input: readMe)
    }
}
