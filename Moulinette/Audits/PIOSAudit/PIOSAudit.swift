//
//  PIOSAudit.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// PiOS Audit.
struct PIOSAudit: Audit {
    
    private var projectData: ProjectData
    private var configurationFile: ConfigurationFile?

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
    
    init(projectData: ProjectData, configurationFile: ConfigurationFile?) {
        self.projectData = projectData
        self.configurationFile = configurationFile
    }
    
    func runRules() -> Output {
        let output = Output(with: settings.projectIdentifier, projectName: settings.projectName) 
        var auditScore: Double = 0
        
        /// Dispatch group - Flag rules running concurrently and wait until all of them are done.
        let group = DispatchGroup()

        for collection in ruleCollection {
            for rule in collection.rules() {
                guard !(configurationFile?.excludedRules.contains(rule.nameId) ?? false) else {
                    continue
                }

                group.enter()

                /// Dispatch the block in a concurrent queue (global).
                DispatchQueue.global().async {
                    let result = rule.run(projectData: self.projectData)
                    let score = result.score()
                    let report = result.violationDescription
                    var violations = result.violations

                    auditScore += score

                    if let rule = rule as? CorrectableSwiftRule {
                        let fileCorrections = rule.correct(projectData: self.projectData)
                        self.projectData.add(corrections: fileCorrections)
                        violations = []
                    }

                    output.record(collection: collection.description,
                                  rule: rule.description,
                                  score: score,
                                  weight: rule.priority.weight(),
                                  report: report,
                                  violationCount: result.violationCount,
                                  violations: violations)
                    group.leave()
                }
            }
        }

        group.wait()
        projectData.applyCorrections()
        let score = Int((auditScore / maxPoints()) * 100)
        output.record(overallScore: score)
        return output
    }

    func autoCorrect() {
        for (fileName, fileContents) in projectData.correctedProjectComponents {
            guard fileContents != projectData.applicationComponents.components[fileName] else {
                continue
            }
            let fileDirectory = "file://" + settings.projectDirectory + fileName
            let fileString = fileContents.joined(separator: "\n")
            fileString.writeToFile(directory: fileDirectory.replacingOccurrences(of: " ", with: "%20"))
        }
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
