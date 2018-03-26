//
//  GitCheckMergedBranchSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Morgan Collino on 10/17/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Git check merged branch swift rule.
class GitCheckMergedBranchSwiftRule: SwiftRule {
    
    let name: String = "Git - Check merged branches upstream."
    let priority: RulePriority = .high
    
    private var projectData: ProjectData
    
    fileprivate lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    required init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        evaluateMergedBranches()
        return auditGrader.generateGrade()
    }
    
    /// Filter branches and excluding certain names.
    ///
    /// - Parameter branch: Branch name.
    /// - Returns: True if the branch shouldnt be filtered out, False else.
    func filterBranches(branch: String) -> Bool {
        // Avoid branches like Beta/Release/Master/Develop/Empty strings
        if branch.contains("beta") || branch.contains("master")
            || branch.contains("release") || branch.contains("develop")
            || branch.isEmpty {
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

    /// Evaluate merged branches.
    func evaluateMergedBranches() {
        do {
            guard let results = try getMergedBranches()?
                .filter(filterBranches)
                .map(removeWhiteSpaces) else {
                return
            }
            
            // Add violation for each branch found.
            results.forEach { (branch) in
                auditGrader.violationFound(fileName: branch, lineNumber: nil, description: "Branch: \(branch) has been merged but not deleted.")
            }
        } catch {
            // void
        }
    }
    
    /// Get merged branches upstream (not deleted).
    ///
    /// - Returns: Merged branches not deleted in a form of array of strings.
    /// - Throws: Throws error if script fails.
    func getMergedBranches() throws -> [String]? {
        let script = Script(command: "/usr/bin/git")
        let res = try script.execute(args: ["--git-dir=\(projectData.path).git", "branch", "-r", "--merged"])
        let results = res.components(separatedBy: "\n")
        return results
    }
    
}
