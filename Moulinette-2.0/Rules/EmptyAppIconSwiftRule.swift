//
//  EmptyAppIconSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Checks the project for empty app icons assets.
final class EmptyAppIconSwiftRule: SwiftRule {
    
    let name: String = "Empty Icon in Assets"
    let priority: RulePriority = .high
    
    private var projectData: ProjectData
    
    fileprivate lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        let assetContents = projectData.applicationComponents.assets
        
        for (filePath, components) in assetContents {
            if filePath.contains("AppIcon") {
                checkContentsFile(filePath: filePath, components: components)
            }
        }
        
        return auditGrader.generateGrade()
    }
}

private extension EmptyAppIconSwiftRule {
    
    func checkContentsFile(filePath: String, components: FileComponents) {
        var size: String?
        for component in components {
            if component.contains("size") {
                check(size: size, filePath: filePath, description: component)
                size = component
            }
            size = component.contains("filename") ? nil : size
        }
        check(size: size, filePath: filePath, description: "Missing filename for last icon asset.")
    }
    
    private func check(size: String?, filePath: String, description: String) {
        if size != nil {
            auditGrader.violationFound(fileName: filePath, lineNumber: nil, description: description)
        }
    }
}
