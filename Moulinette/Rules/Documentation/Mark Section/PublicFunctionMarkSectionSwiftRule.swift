//
//  PublicFunctionMarkSectionSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 4/13/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

final class PublicFunctionMarkSectionSwiftRule: CorrectableSwiftRule {

    let description: String = "MARK needed for public functions."
    let nameId = "mark_public_functions"

    let priority: RulePriority = .low

    private var contextCheck = ContextCheck()

    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    private var tabbedMarkDescription: String {
        return "\t" + Constants.markFormat + "Public Functions"
    }

    private var spacedMarkDescription: String {
        return "    " + Constants.markFormat + "Public Functions"
    }

    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.swiftFiles {
            contextCheck.resetContext()

            for index in 0..<fileComponents.count {
                let line = fileComponents[index]

                if line.contains("func "),
                    !line.contains("private "),
                    !line.isComment(),
                    !fileComponents.contains(tabbedMarkDescription),
                    !fileComponents.contains(spacedMarkDescription),
                    (contextCheck.currentContext == .classContext) {

                    auditGrader.violationFound(fileName: fileName,
                                               lineNumber: index + 1,
                                               description: description,
                                               nameId: nameId)
                    break
                }
                contextCheck.check(fileLine: line)
            }
        }
        return auditGrader.generateGrade()
    }

    func correct(projectData: ProjectData) -> [FileCorrection] {
        return auditGrader.violations.compactMap({ (violation) -> FileCorrection? in
            guard let lineNumber = violation.lineNumber,
                let fileComponents = projectData.applicationComponents.components[violation.fileName] else {
                    return nil
            }
            let insertLineNumber = fileComponents.aboveCommentLineNumber(violationLineNumber: lineNumber)
            let lineInsertions = [Line(lineNumber: insertLineNumber, codeString: "\n\(spacedMarkDescription)")]
            return FileCorrection(fileName: violation.fileName,
                                  lineNumber: lineNumber,
                                  customString: nil,
                                  lineInsertions: lineInsertions,
                                  lineDeletions: [])
        })
    }

}
