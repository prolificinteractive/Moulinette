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
    private var ruleCollection: [RuleCollection] = [
        ProjectConventionRuleCollection(),
        CodeConventionRuleCollection(),
        LocalizationRuleCollection(),
        APIIntegrationRuleCollection(),
        DocumentationRuleCollection(),
        CompilerRuleCollection(),
        TestsCoverageRuleCollection(),
        ToolsRuleCollection(),
        DependenciesRuleCollection(),
        CIRuleCollection(),
        GitRuleCollection(),
        AppstoreRuleCollection(),
        SecurityRuleCollection()
    ]
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func runRules() -> Output {
        let output = Output(with: settings.projectIdentifier, projectName: settings.projectName) 
        var auditScore: Double = 0
        
        /// Dispatch group - Flag rules running concurrently and wait until all of them are done.
        let group = DispatchGroup()
        
        for collection in ruleCollection {
            collection.rules().forEach({ rule in
                group.enter()
                
                /// Dispatch the block in a concurrent queue (global).
                DispatchQueue.global().async {
                    let result = rule.run(projectData: self.projectData)
                    let score = result.score()
                    let report = result.violationDescription
                    auditScore += score
                    output.record(collection: collection.description,
                                  rule: rule.name,
                                  score: score,
                                  weight: rule.priority.weight(),
                                  report: report,
                                  violationCount: result.violationCount,
                                  violations: result.violations)
                    group.leave()
                }
            })
        }
        
        group.wait()
        let score = Int((auditScore / maxPoints()) * 100)
        output.record(overallScore: score)
        return output
    }
    
    private func maxPoints() -> Double {
        var points: Double = 0
        ruleCollection.forEach {
            $0.rules().forEach {
                points += $0.priority.weight()
            }
        }
        return points
    }
}
