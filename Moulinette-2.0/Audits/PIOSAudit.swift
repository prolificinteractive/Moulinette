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
    private var ruleCollection: [RuleCollection] = [CodeConventionRuleCollection()]
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func runRules() -> AuditScore {
        print("Running PiOS Rules for " + settings.projectName + ":")
        
        var auditScore: Double = 0
        
        for collection in ruleCollection {
            collection.rules(projectData: projectData).forEach {
                let score = $0.run().score()
                auditScore += score
                print(" - " + $0.name + ": " + String(score) + " / " + String($0.priority.weight()))
            }
        }
        
        let score = Int((auditScore / maxPoints()) * 100)
        print("Score: " + String(score))
        return AuditScore(score: score)
    }
    
    func maxPoints() -> Double {
        var points: Double = 0
        ruleCollection.forEach {
            $0.rules(projectData: projectData).forEach {
                points += $0.priority.weight()
            }
        }
        return points
    }
}
