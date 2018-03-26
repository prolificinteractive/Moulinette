//
//  GitCheckCommitQualitySwiftRule.swift
//  Moulinette-2.0
//
//  Created by Morgan Collino on 10/18/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Commit structure.
struct Commit {
    let hash: String
    let author: String
    let date: String
    let message: String
}

/// Git check merged branch swift rule.
class GitCheckCommitQualitySwiftRule: SwiftRule {
    
    fileprivate let minimumWordNumber = 3
    fileprivate let numberOfDaysBack: TimeInterval = 30

    let name: String = "Git - Check commits message quality. Minimum 3 words for commit message."
    let priority: RulePriority = .medium
    
    private var projectData: ProjectData
    
    fileprivate lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    required init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        evaluateCommitQuality()
        return auditGrader.generateGrade()
    }
    
    /// Get list of commits.
    ///
    /// - Returns: List of commits.
    /// - Throws: Error if Git return an error.
    func getCommits() throws -> [Commit] {
        // git --no-pager log --since=09/18/2017 --no-merges
        let script = Script(command: "/usr/bin/git")
        
        let dateString = getLastMonthDate()
        
        let res = try script.execute(args: ["--git-dir=\(projectData.path).git", "--no-pager", "log", "--since=\(dateString)", "--no-merges"])
        return parseCommits(from: res)
    }
    
    /// Parse commits from string.
    ///
    /// - Parameter log: Log string (Result of the git command line).
    /// - Returns: List of commit from last month.
    func parseCommits(from log: String) -> [Commit] {
        let lines = log.components(separatedBy: "\n")
        var commitBuilding = false
        var commits = [Commit]()
        
        var commitHash = ""
        var author = ""
        var date = ""
        var text = ""
        lines.forEach { (line) in
            if line.contains("commit") {
                if commitBuilding == true {
                    let commit = Commit(hash: commitHash, author: author, date: date, message: text)
                    commits.append(commit)
                    text = ""
                }
                commitBuilding = true
                commitHash = line
            } else if line.contains("Author") {
                author = line
            } else if line.contains("Date") {
                date = line
            } else if !line.isEmpty {
                text = text + line + "\n"
                text = text.trimmingCharacters(in: .whitespaces)
            }
        }
        
        // Get last commit.
        let commit = Commit(hash: commitHash, author: author, date: date, message: text)
        commits.append(commit)
        return commits
    }
    
}

private extension GitCheckCommitQualitySwiftRule {
    
    /// Evaluate commit quality.
    func evaluateCommitQuality() {
        do {
            let commits = try getCommits()
            checkCommits(commits: commits)
        } catch {
            // void
        }
    }
    
    /// Get last month date string.
    ///
    /// - Returns: Date string: Format: MM/dd/yyyy.
    func getLastMonthDate() -> String {
        let date = Date()
        
        let hoursInDay: TimeInterval = 24
        let minutesInHour: TimeInterval = 60
        let secondsInMinute: TimeInterval = 60
        
        // Get number of seconds since numberOfDaysBack days
        let interval: TimeInterval = -numberOfDaysBack*hoursInDay*minutesInHour*secondsInMinute
        let lastMonthDate = date.addingTimeInterval(interval)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: lastMonthDate)
    }
    
    /// Check commits message.
    ///
    /// - Parameter commits: List of commits.
    func checkCommits(commits: [Commit]) {
        commits.forEach { (commit) in
            let components = commit.message.components(separatedBy: .whitespacesAndNewlines)
            let words = components.filter { !$0.isEmpty }
            if words.count < minimumWordNumber {
                auditGrader.violationFound(fileName: "Git", lineNumber: nil, description: "Bad commit format. Hash: \(commit.hash), comment:\(commit.message), \(commit.date).")
            }
        }
    }
    
    
}
