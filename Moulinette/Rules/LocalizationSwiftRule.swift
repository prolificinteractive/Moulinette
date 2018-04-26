//
//  LocalizationSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 4/16/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

final class LocalizationSwiftRule: SwiftRule {

    let description: String = "MARK needed for initialization."
    let nameId = "mark_localization"

    let priority: RulePriority = .high

    private static let localizationFunction = "localize"

    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    func run(projectData: ProjectData) -> AuditGrade {
        for (_, fileComponents) in projectData.applicationComponents.swiftFiles {

            for index in 0..<fileComponents.count {
                let line = fileComponents[index]


                if let index = stringRange(line: line) {
                    print("HELLO WORLD")
                    print(line)
                    print(index.startIndex)
                }



                if !line.contains(LocalizationSwiftRule.localizationFunction),
                    !line.isComment(), line.contains("\"")
                    {

//                    auditGrader.violationFound(fileName: fileName,
//                                               lineNumber: index + 1,
//                                               description: name)
                    break
                }
            }
        }
        return auditGrader.generateGrade()
    }

}

private extension LocalizationSwiftRule {

    func stringRange(line: String) -> (startIndex: String.Index, endIndex: String.Index)? {
        var startIndex: String.Index?
        var endIndex: String.Index?
        var escapeCharacter = false

        for char in line {
            if char == "\\" {
                escapeCharacter = true
                continue
            }

            if escapeCharacter {
                escapeCharacter = false
                continue
            }

            if char == "\"" && startIndex == nil {
                startIndex = line.index(of: char)
                continue
            }

            if char == "\"" && startIndex != nil {
                endIndex = line.index(of: char)
            }
        }

        guard let startStringIndex = startIndex, let endStringIndex = endIndex else {
            return nil
        }
        return (startStringIndex, endStringIndex)
    }

}
