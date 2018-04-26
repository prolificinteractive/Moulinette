//
//  ProtocolExtensionMarkSectionSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 4/13/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

final class ProtocolExtensionMarkSectionSwiftRule: CorrectableSwiftRule {

    let description = "MARK needed for protocol extensions."
    let nameId = "mark_protocol_extension"

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

                if line.contains("extension "),
                    line.contains(":"),
                    !line.isComment(),
                    !fileComponents.contains(protocolString(line: line)),
                    contextCheck.currentContext == .extensionContext {

                    auditGrader.violationFound(fileName: fileName,
                                               lineNumber: index + 1,
                                               description: description,
                                               nameId: nameId)
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
            let lineInsertions = [Line(lineNumber: lineNumber, codeString: protocolString(line: line))]
            return FileCorrection(fileName: violation.fileName,
                                  lineNumber: lineNumber,
                                  customString: nil,
                                  lineInsertions: lineInsertions,
                                  lineDeletions: [])
        })
    }
    
}

private extension ProtocolExtensionMarkSectionSwiftRule {

    func protocolString(line: String) -> String {
        let protocols = line.removeLeading(startWith: ":").replacingOccurrences(of: "{", with: "").stringWithoutWhitespaces().components(separatedBy: ",")
        return Constants.markFormat + protocols.joined(separator: ", ")
    }

}
