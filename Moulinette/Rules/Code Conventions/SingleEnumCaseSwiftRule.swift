//
//  SingleEnumCaseSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class SingleEnumCaseSwiftRule: CorrectableSwiftRule {
    
    let description: String = "Enums (one case statement per line)"
    let nameId = "enum_single_case"

    let priority: RulePriority = .medium
    
    private var contextCheck = ContextCheck()
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            contextCheck.resetContext()
            fileComponents.forEach {
                contextCheck.check(fileLine: $0)
                
                if contextCheck.currentContext == .enumContext, !$0.isComment(),
                    $0.contains("case ") && $0.contains(",")
                    && !($0.contains("var ") || $0.contains("let ") || $0.contains("(")) {
                    
                    auditGrader.violationFound(fileName: fileName,
                                               lineNumber: fileComponents.lineNumberFor($0),
                                               description: description,
                                               nameId: nameId)
                }
            }
        }
        return auditGrader.generateGrade()
    }

    func correct(projectData: ProjectData) -> [FileCorrection] {
        return auditGrader.violations.compactMap({ (violation) -> FileCorrection? in
            if let lineNumber = violation.lineNumber,
                let fileComponents  = projectData.applicationComponents.components[violation.fileName] {

                let index = lineNumber - 1
                let currentLine = fileComponents[index]
                let cases = enumCases(enumLine: currentLine)
                let lines = enumLines(lineNumber: lineNumber, cases: cases)

                return FileCorrection(fileName: violation.fileName,
                                      lineNumber: lineNumber,
                                      customString: nil,
                                      lineInsertions: lines,
                                      lineDeletions: [lineNumber])
            }
            return nil
        })
    }
}

private extension SingleEnumCaseSwiftRule {

    func enumLines(lineNumber: Int, cases: [String]) -> [Line] {
        var lines = [String]()
        for index in 0..<cases.count {
            lines.append("\tcase \(cases[index])")
        }
        return [Line(lineNumber: lineNumber, codeString: lines.joined(separator: "\n"))]
    }

    func enumCases(enumLine: String) -> [String] {
        let casesString = enumLine.replacingOccurrences(of: "case", with: "")
        return casesString.stringWithoutWhitespaces().components(separatedBy: ",")
    }
}
