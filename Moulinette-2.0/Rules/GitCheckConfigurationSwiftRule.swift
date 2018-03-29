//
//  GitCheckConfigurationSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Morgan Collino on 12/18/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Git project contains a gitignore file.
final class GitCheckConfigurationSwiftRule: SwiftRule {
    
    let name: String = "Git - Check project contains a .gitignore file."
    let priority: RulePriority = .low
        
    fileprivate lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        // check project has .gitignore file
        guard let _ = projectData.applicationComponents.file(by: Constants.FileNameConstants.gitIgnore) else {
            auditGrader.failed(fileName: Constants.FileNameConstants.gitIgnore,
                               description: "Gitignore could not be found!")
            return auditGrader.generateGrade()
        }
        
        return auditGrader.generateGrade()
    }
    
}
