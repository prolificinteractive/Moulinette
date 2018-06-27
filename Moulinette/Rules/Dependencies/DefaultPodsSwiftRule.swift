//
//  DefaultPodsSwiftRule.swift
//  Moulinette
//
//  Created by Adam Tecle on 7/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Defines rule that every project should include a set of default CocoaPods.
final class DefaultPodsSwiftRule: SwiftRule {

    // MARK: - Public 

    let description = "Project should include default pods - \(requiredPods.joined(separator: ", "))"
    let nameId = "default_pods"

    let priority: RulePriority = .high

    // MARK: - Private

    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    private let fileName = "Podfile"
    private static let requiredPods = ["Bellerophon", "Crashlytics", "Instabug", "HockeySDK", "Yoshi"]

    func run(projectData: ProjectData) -> AuditGrade {
        guard let podfile = projectData.applicationComponents.file(by: fileName) else {
            return auditGrader.generateGrade()
        }

        var pods: [String] = []
        PodfileParser.parse(podfile) { [unowned self] tokens, line, _ in
            let podName = self.extractCocoaPodName(from: tokens)
            if DefaultPodsSwiftRule.requiredPods.contains(podName) {
                pods.append(podName)
            }
        }

        let defaultPods = Set(DefaultPodsSwiftRule.requiredPods)
        let foundPods = Set(pods)
        let unfoundPods = defaultPods.subtracting(foundPods)
        for pod in unfoundPods {
            auditGrader.violationFound(fileName: fileName, lineNumber: nil, description: "Missing pod: \(pod)", nameId: nameId)
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
