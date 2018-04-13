//
//  ProtocolExtensionMarkSectionSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 4/13/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

final class ProtocolExtensionMarkSectionSwiftRule: CorrectableSwiftRule {

    let name: String = "MARK needed for protocol extensions."
    let priority: RulePriority = .low

    private var contextCheck = ContextCheck()

    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.swiftFiles {
            contextCheck.resetContext()

            for index in 0..<fileComponents.count {
                let line = fileComponents[index]
                contextCheck.check(fileLine: line)

                let protocolString = line.removeLeading(startWith: ":").replacingOccurrences(of: "{", with: "").stringWithoutWhitespaces()

                if line.contains("extension"),
                    line.contains(":"),
                    !fileComponents.contains(Constants.markFormat + protocolString),
                    contextCheck.currentContext == .extensionContext {

                    auditGrader.violationFound(fileName: fileName,
                                               lineNumber: index + 1,
                                               description: name)
                }
            }
        }
        return auditGrader.generateGrade()
    }

    func correct(projectData: ProjectData) -> [FileCorrection] {
        return auditGrader.violations.flatMap({ (violation) -> FileCorrection? in
            guard let lineNumber = violation.lineNumber,
                let fileComponents = projectData.applicationComponents.components[violation.fileName] else {
                    return nil
            }
            let line = fileComponents[lineNumber - 1]
            let protocolString = line.removeLeading(startWith: ":").replacingOccurrences(of: "{", with: "").stringWithoutWhitespaces()
            let lineInsertions = [Line(lineNumber: lineNumber, codeString: Constants.markFormat + protocolString)]
            return FileCorrection(fileName: violation.fileName,
                                  lineNumber: lineNumber,
                                  customString: nil,
                                  lineInsertions: lineInsertions,
                                  lineDeletions: [])
        })
    }

}
