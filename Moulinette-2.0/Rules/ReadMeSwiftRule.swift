//
//  ReadMeSwiftRule.swift
//  Moulinette
//
//  Created by Ruchi Jain on 7/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Defines rule for README.md file
final class ReadMeSwiftRule: SwiftRule {
    
    let description = "README.md should not contain any TODO items"
    let nameId = "readme_todos"

    let priority: RulePriority = .low
    
    private let fileName = Constants.FileNameConstants.readme
        
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        guard let readmeComponents = projectData.applicationComponents.readmeComponents else {
            auditGrader.failed(fileName: fileName, description: "No README found!!!", nameId: nameId)
            return auditGrader.generateGrade()
        }

        let readMe = readmeComponents.joined(separator: " ")
        
        if hasToDoItems(in: readMe) {
            auditGrader.violationFound(fileName: fileName, lineNumber: nil, description: description, nameId: nameId)
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
