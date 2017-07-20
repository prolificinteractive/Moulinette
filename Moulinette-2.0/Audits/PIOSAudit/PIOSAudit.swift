//
//  PIOSAudit.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// PiOS Audit.
struct PIOSAudit: Audit {
    
    private var projectData: ProjectData
    private var ruleCollection: [RuleCollection] = [CodeConventionRuleCollection()]
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func runRules() -> Output {
        let output = Output(with: settings.projectIdentifier, projectName: settings.projectName) 
        var auditScore: Double = 0
        for collection in ruleCollection {
            collection.rules(projectData: projectData).forEach {
                let score = $0.run().score()
                auditScore += score
                output.record(rule: $0.name, score: score, weight: $0.priority.weight())
            }
        }
        
        let score = Int((auditScore / maxPoints()) * 100)
        output.record(overallScore: score)
        return output
    }
    
    private func maxPoints() -> Double {
        var points: Double = 0
        ruleCollection.forEach {
            $0.rules(projectData: projectData).forEach {
                points += $0.priority.weight()
            }
        }
        return points
    }
}
