//
//  GitCheckBranchNameSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Morgan Collino on 12/18/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Git check branch naming swift rule.
final class GitCheckBranchNameSwiftRule: SwiftRule {
    
    let name: String = "Git - Check branch naming upstream."
    let priority: RulePriority = .low
    
    private var projectData: ProjectData
    
    fileprivate lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        evaluateOpenedBranches()
        return auditGrader.generateGrade()
    }
    
}

private extension GitCheckBranchNameSwiftRule {
    
    /// Evaluate merged branches.
    func evaluateOpenedBranches() {
        do {
            guard let results = try getOpenedBranches()?.filter({ (branch) -> Bool in
                // Avoid branches containing Beta/Release/Master/Develop/Empty strings
                if branch.contains("beta") || branch.contains("master")
                    || branch.contains("release/") || branch.contains("develop")
                    || branch.contains("chore/") || branch.contains("feature/")
                    || branch.contains("bugfix/") ||  branch.contains("rc/") || branch.isEmpty {
                    return false
                }
                return true
            }).map({ (branch) -> String in
                // Remove whitespaces
                return branch.trimmingCharacters(in: .whitespaces)
            }) else {
                return
            }
            
            // Add violation for each branch found.
            results.forEach { (branch) in
                auditGrader.violationFound(fileName: branch, description: "Open branch: '\(branch)' has been badly named.")
            }
        } catch {
            // void
        }        
    }
    
    /// Get opened branches upstream.
    ///
    /// - Returns: Opened branches not deleted in a form of array of strings.
    /// - Throws: Throws error if script fails.
    func getOpenedBranches() throws -> [String]? {
        let script = Script(command: "/usr/bin/git")
        let res = try script.execute(args: ["--git-dir=\(projectData.path).git", "branch", "-r", "--no-merged"])
        let results = res.components(separatedBy: "\n")
        return results
    }
    
}

