//
//  ProjectOrganizationSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Checks if the project's organization includes the given default folders.
final class ProjectOrganizationSwiftRule: SwiftRule {
    
    /// Default project folders.
    static let defaultFolders = ["Features", "Model", "Utility", "Resources", "Supporting Files"]

    let name: String = "Default project folders used"
    let priority: RulePriority = .low
    
    private var projectData: ProjectData
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        var projectFolders = ProjectOrganizationSwiftRule.defaultFolders
        
        projectData.applicationComponents.filePaths.forEach {
            let filepathInfo = filepathContainsDefaultFolder(filepath: $0, defaultFolders: projectFolders)
            if filepathInfo.found {
                projectFolders.remove(at: filepathInfo.index)
            }
        }
        
        projectFolders.forEach {
            auditGrader.violationFound(fileName: $0, description: "Not found in project folder structure")
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
