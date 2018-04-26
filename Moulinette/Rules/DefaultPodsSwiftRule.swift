//
//  DefaultPodsSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Adam Tecle on 7/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Defines rule that every project should include a set of default CocoaPods.
final class DefaultPodsSwiftRule: SwiftRule {

    // MARK: - Public 

    let name: String = "Project should include default pods - \(requiredPods.joined(separator: ", "))"
    let priority: RulePriority = .high

    // MARK: - Private

    private var projectData: ProjectData
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    private let fileName = "Podfile"
    private static let requiredPods = ["Bellerophon", "Crashlytics", "Instabug", "HockeySDK", "Yoshi"]

    init(projectData: ProjectData) {
        self.projectData = projectData
    }

    func run() -> AuditGrade {
        guard let podfile = projectData.applicationComponents.file(by: fileName) else {
            return auditGrader.generateGrade()
        }

        var pods: [String] = []
        PodfileParser.parse(podfile) { [unowned self] tokens, line in
            let podName = self.extractCocoaPodName(from: tokens)
            if DefaultPodsSwiftRule.requiredPods.contains(podName) {
                pods.append(podName)
            }
        }

        let defaultPods = Set(DefaultPodsSwiftRule.requiredPods)
        let foundPods = Set(pods)
        let unfoundPods = defaultPods.subtracting(foundPods)
        for pod in unfoundPods {
            auditGrader.violationFound(fileName: fileName, description: "Missing pod: \(pod)")
        }

        return auditGrader.generateGrade()
    }

    private func extractCocoaPodName(from tokens: [String]) -> String {
        guard tokens.count > 1 else {
            return ""
        }
        return tokens[1].trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    }
    
}
