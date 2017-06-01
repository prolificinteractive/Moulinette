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
    
    private var projectData: ProjectData
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> GradeType {
        let fileComponent = projectData.applicationComponents[Constants.FileNameConstants.appDelegate]
        
        if let compoent = fileComponent, compoent.count > 100 {
            return .fail("Line Count Above 100, Actual: " + String(compoent.count))
        }
        return .pass
    }
}
