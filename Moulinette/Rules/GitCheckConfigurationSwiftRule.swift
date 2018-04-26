//
//  GitCheckConfigurationSwiftRule.swift
//  Moulinette
//
//  Created by Morgan Collino on 12/18/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Git project contains a gitignore file.
final class GitCheckConfigurationSwiftRule: SwiftRule {
    
    let description = "Git - Check project contains a .gitignore file."
    let nameId = ".gitignore_needed"

    let priority: RulePriority = .low
        
    fileprivate lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        // check project has .gitignore file
        guard let _ = projectData.applicationComponents.file(by: Constants.FileNameConstants.gitIgnore) else {
            auditGrader.failed(fileName: Constants.FileNameConstants.gitIgnore,
                               description: "Gitignore could not be found!",
                               nameId: nameId)
            return auditGrader.generateGrade()
        }
        
        return auditGrader.generateGrade()
    }
    
}
