//
//  GitCheckBranchNameSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Morgan Collino on 12/18/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Git check branch naming swift rule.
class GitCheckBranchNameSwiftRule: SwiftRule {
    
    let description = "Git - Check branch naming upstream."
    let nameId = "git_naming"

    let priority: RulePriority = .low
        
    fileprivate lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        evaluateOpenedBranches()
        return auditGrader.generateGrade()
    }
 
    /// Filter branches and excluding certain names.
    ///
    /// - Parameter branch: Branch name.
    /// - Returns: True if the branch shouldnt be filtered out, False else.
    func filterBranches(branch: String) -> Bool {
        // Avoid branches containing Beta/Release/Master/Develop/Empty strings
        if branch.contains("beta") || branch.contains("master")
            || branch.contains("release/") || branch.contains("develop")
            || branch.contains("chore/") || branch.contains("feature/")
            || branch.contains("bugfix/") ||  branch.contains("rc/") || branch.isEmpty {
            return false
        }
        return true
    }
    
    /// Remove white spaces.
    ///
    /// - Parameter string: String to remove whitespaces from.
    /// - Returns: Cleared out string.
    func removeWhiteSpaces(string: String) -> String {
        return string.trimmingCharacters(in: .whitespaces)
    }
    
    /// Evaluate opened branches.
    func evaluateOpenedBranches() {
        do {
            guard let results = try getOpenedBranches()?
                .filter(filterBranches)
                .map(removeWhiteSpaces) else {
                return
            }
            
            // Add violation for each branch found.
            results.forEach { (branch) in
                auditGrader.violationFound(fileName: branch, lineNumber: nil, description: "Open branch: '\(branch)' has been badly named.", nameId: nameId)
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

