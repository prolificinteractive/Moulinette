//
//  PIOSAudit.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

internal struct PIOSAudit: Audit {
    
    private var projectData: ProjectData
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func runRules() {
        print("Running PiOS Rules:")
        
        CodeRuleType.availableRules(projectData: projectData).forEach {
            print(" - " + $0.name + ": " + $0.run().gradeText())
        }
    }
}
