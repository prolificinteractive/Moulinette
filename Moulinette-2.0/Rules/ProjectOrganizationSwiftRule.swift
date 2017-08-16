//
//  ProjectOrganizationSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class ProjectOrganizationSwiftRule: SwiftRule {
    
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
        var defaultFolders = Constants.defaultfolders
        
        projectData.applicationComponents.filePaths.forEach {
            let filepathInfo = filepathContainsDefaultFolder(filepath: $0, defaultFolders: defaultFolders)
            if filepathInfo.found {
                defaultFolders.remove(at: filepathInfo.index)
            }
        }
        
        defaultFolders.forEach {
            auditGrader.violationFound(fileName: $0, description: "Not found in project folder structure")
        }
        
        return auditGrader.generateGrade()
    }
}

private extension ProjectOrganizationSwiftRule {
    
    func filepathContainsDefaultFolder(filepath: String, defaultFolders: [String]) -> (found: Bool, index: Int) {
        for i in 0..<defaultFolders.count {
            if filepath.contains(defaultFolders[i]) {
                print(filepath)
                return (true, i)
            }
        }
        return (false, -1)
    }
}
