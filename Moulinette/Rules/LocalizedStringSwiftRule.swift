//
//  LocalizedStringSwiftRule.swift
//  Moulinette
//
//  Created by Morgan Collino on 7/14/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

typealias KeyInfo = [(fileName: String, index: Int, key: String)]

// Check localized string usage rule.
final class LocalizedStringSwiftRule: CorrectableSwiftRule {
    
    // MARK: - Public Properties
    
    let description = "Check if the localized string keys are used."
    let nameId = "localized_keys"

    let priority: RulePriority = .high
    
    // MARK: - Private Properties
    
    private let separator = "="
    private let space = " "
    private let empty = ""
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    // MARK: - Public Functions
    
    func run(projectData: ProjectData) -> AuditGrade {
        let stringFiles = projectData.applicationComponents.stringFiles
        let swiftFiles = projectData.applicationComponents.swiftFiles
        let objectiveCFiles = projectData.applicationComponents.objectiveCFiles

        let filesContent = allFilesContent(with: swiftFiles) + allFilesContent(with: objectiveCFiles)
        let keys = getKeys(with: stringFiles)

        checkKeysUsage(with: keys, fileContent: filesContent)
        
        return auditGrader.generateGrade()
    }

    func correct(projectData: ProjectData) -> [FileCorrection] {
        return auditGrader.violations.compactMap({ (violation) -> FileCorrection? in
            guard let lineNumber = violation.lineNumber,
                let fileComponents = projectData.applicationComponents.components[violation.fileName] else {
                return nil
            }
            
            return FileCorrection(fileName: violation.fileName,
                                  lineNumber: lineNumber,
                                  customString: nil,
                                  lineInsertions: nil,
                                  lineDeletions: fileComponents.removeCommentEmptyStrings(lineNumber: lineNumber))
        })
    }

}

// MARK: - Private Functions
private extension LocalizedStringSwiftRule {

    func allFilesContent(with files: FileCollection) -> String {
        return files.compactMap { (fileName, fileContents) -> String? in
            return fileContents.joined()
            }.joined()
    }

    func getKeys(with stringFiles: FileCollection) -> KeyInfo {
        var keyInfo = KeyInfo()

        for (fileName, fileComponents) in stringFiles {
            for line in fileComponents {
                if line.contains(separator), let index = fileComponents.index(of: line) {
                    let split = line.split(at: separator)
                    guard let key = split?.leftString else {
                        continue
                    }
                    keyInfo.append((fileName, index, key))
                }
            }
        }

        return keyInfo
    }

    func checkKeysUsage(with keyInfo: KeyInfo, fileContent: String) {
        for info in keyInfo {
            if !fileContent.contains(info.key) {
                auditGrader.violationFound(fileName: info.fileName,
                                           lineNumber: info.index+1,
                                           description: "Missing usage of localized key: \(info.key)", nameId: nameId)
            }
        }
    }

}
