//
//  LocalizedStringSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Morgan Collino on 7/14/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

// Check localized string usage rule.
final class LocalizedStringSwiftRule: SwiftRule {
    
    // MARK: - Public properties
    
    let name: String = "Check if the localized string keys are used."
    let priority: RulePriority = .high
    
    // MARK: - Private properties
    
    private let separator = "="
    private let space = " "
    private let empty = ""
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    // MARK: - Public functions
    
    func run(projectData: ProjectData) -> AuditGrade {
        let stringFiles = projectData.applicationComponents.stringFiles
        let swiftFiles = projectData.applicationComponents.swiftFiles
        
        let allSwiftFilesContent = allFilesContent(with: swiftFiles)
        let keys = getKeys(with: stringFiles)
        
        checkKeysUsage(with: keys, fileContent: allSwiftFilesContent)
        
        return auditGrader.generateGrade()
    }
    
    // MARK: - Private functions
    
    private func allFilesContent(with files: [(String, [String])]) -> String {
        return files.flatMap { (fileName, fileContents) -> String? in
            return fileContents.joined()
            }.joined()
    }
    
    private func getKeys(with stringFiles: [(String, [String])]) -> [String] {
        var keys: [String] = []
        
        for (_, fileComponents) in stringFiles {
            for line in fileComponents {
                let trimmedString = line.replacingOccurrences(of: space, with: empty)
                if trimmedString.contains(separator) {
                    let split = trimmedString.split(at: separator)
                    guard let key = split?.leftString else {
                        continue
                    }
                    keys.append(key)
                }
            }
        }
        
        return keys
    }
    
    private func checkKeysUsage(with keys: [String], fileContent: String) {
        for key in keys {
            if !fileContent.contains(key) {
                auditGrader.violationFound(fileName: "*",
                                           lineNumber: nil,
                                           description: "Missing usage of localized key: \(key)")
            }
        }
    }
    
}
