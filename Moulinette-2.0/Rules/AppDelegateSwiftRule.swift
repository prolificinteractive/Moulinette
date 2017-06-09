//
//  AppDelegateSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/30/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class AppDelegateSwiftRule: SwiftRule {
    
    let name: String = "AppDelegate Clean"
    let priority: RulePriority = .medium
    
    private var projectData: ProjectData
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        let fileComponent = projectData.applicationComponents[Constants.FileNameConstants.appDelegate]
        
        if let component = fileComponent, component.count > 100 {
            auditGrader.violationFound(fileName: Constants.FileNameConstants.appDelegate,
                                       description: "Line Count Above 100, Actual: " + String(component.count))
        }
        return auditGrader.generateGrade()
    }
}
