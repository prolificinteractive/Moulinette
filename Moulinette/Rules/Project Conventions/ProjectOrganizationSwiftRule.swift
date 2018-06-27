//
//  ProjectOrganizationSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 8/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Checks if the project's organization includes the given default folders.
final class ProjectOrganizationSwiftRule: SwiftRule {
    
    /// Default project folders.
    static let defaultFolders = ["Features", "Model", "Utility", "Resources", "Supporting Files"]

    let description = "Default project folders used"
    let nameId = "default_folders"

    let priority: RulePriority = .low
        
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        var projectFolders = ProjectOrganizationSwiftRule.defaultFolders
        
        projectData.applicationComponents.filePaths.forEach {
            let filepathInfo = filepathContainsDefaultFolder(filepath: $0, defaultFolders: projectFolders)
            if filepathInfo.found {
                projectFolders.remove(at: filepathInfo.index)
            }
        }
        
        projectFolders.forEach {
            auditGrader.violationFound(fileName: $0, lineNumber: nil, description: "\($0) Not found in project folder structure", nameId: nameId)
        }
        
        return auditGrader.generateGrade()
    }
}

private extension ProjectOrganizationSwiftRule {
    
    func filepathContainsDefaultFolder(filepath: String, defaultFolders: [String]) -> (found: Bool, index: Int) {
        for i in 0..<defaultFolders.count {
            if filepath.contains(defaultFolders[i]) {
                return (true, i)
            }
        }
        return (false, -1)
    }
}
