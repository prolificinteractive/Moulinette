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
        guard let fileComponent = projectData.applicationComponents.file(by: Constants.FileNameConstants.appDelegate) else {
            auditGrader.failed(fileName: Constants.FileNameConstants.appDelegate,
                               description: "No App Delegate Found!!!")
            return auditGrader.generateGrade()
        }
        
        if fileComponent.count > 80 {
            auditGrader.failed(fileName: Constants.FileNameConstants.appDelegate,
                               description: "Line Count Above 80, Actual: " + String(fileComponent.count))
        }
        return auditGrader.generateGrade()
    }
}
