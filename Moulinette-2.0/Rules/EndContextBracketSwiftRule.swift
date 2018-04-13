//
//  EndContextBracketSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 4/12/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

final class EndContextBracketSwiftRule: CorrectableSwiftRule {

    let name: String = "Extra space between brackets."
    let priority: RulePriority = .low

    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.swiftFiles {
            var previousLine = ""

            for index in 0..<fileComponents.count {
                let line = fileComponents[index]
                if line == "}" && previousLine == "    }" {
                    auditGrader.violationFound(fileName: fileName, lineNumber: index + 1, description: name)
                }
                previousLine = line
            }
        }
        return auditGrader.generateGrade()
    }

    func correct(projectData: ProjectData) -> [FileCorrection] {
        return auditGrader.violations.flatMap({ (violation) -> FileCorrection? in
            guard let lineNumber = violation.lineNumber else {
                return nil
            }
            return FileCorrection(fileName: violation.fileName,
                                  lineNumber: lineNumber,
                                  customString: nil,
                                  lineInsertions: [Line(lineNumber: lineNumber, codeString: "")],
                                  lineDeletions: [])

        })
    }
}
