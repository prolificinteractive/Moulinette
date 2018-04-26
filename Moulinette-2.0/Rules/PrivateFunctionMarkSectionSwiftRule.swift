//
//  PrivateFunctionMarkSectionSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 4/13/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

final class PrivateFunctionsMarkSectionSwiftRule: CorrectableSwiftRule {

    let description = "MARK needed for private functions."
    let nameId = "mark_private_functions"

    let priority: RulePriority = .low

    private var contextCheck = ContextCheck()

    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    private var markDescription: String {
        return Constants.markFormat + "Private Functions"
    }

    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.swiftFiles {
            contextCheck.resetContext()

            for index in 0..<fileComponents.count {
                let line = fileComponents[index]
                contextCheck.check(fileLine: line)

                if line.contains("private extension "),
                    !line.isComment(),
                    !fileComponents.contains(markDescription),
                    (contextCheck.currentContext == .extensionContext) {

                    auditGrader.violationFound(fileName: fileName,
                                               lineNumber: index + 1,
                                               description: description,
                                               nameId: nameId)
                    break
                }
            }
        }
        return auditGrader.generateGrade()
    }

    func correct(projectData: ProjectData) -> [FileCorrection] {
        return auditGrader.violations.flatMap({ (violation) -> FileCorrection? in
            guard let lineNumber = violation.lineNumber else {
                    return nil
            }
            let lineInsertions = [Line(lineNumber: lineNumber, codeString: "\(markDescription)")]
            return FileCorrection(fileName: violation.fileName,
                                  lineNumber: lineNumber,
                                  customString: nil,
                                  lineInsertions: lineInsertions,
                                  lineDeletions: [])
        })
    }

}
