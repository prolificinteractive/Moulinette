//
//  SingleEnumCaseSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class SingleEnumCaseSwiftRule: CorrectableSwiftRule {
    
    let name: String = "Enums (one case statement per line)"
    let priority: RulePriority = .medium
    
    private var contextCheck = ContextCheck()
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                contextCheck.check(fileLine: $0)
                
                if contextCheck.insideContext(type: .enumContext), $0.contains("case ") && $0.contains(",") {
                    auditGrader.violationFound(fileName: fileName,
                                               lineNumber: fileComponents.lineNumberFor($0),
                                               description: name)
                }
            }
        }
        return auditGrader.generateGrade()
    }

    func correct(projectData: ProjectData) -> [FileCorrection] {
        var fileCorrections = [FileCorrection]()

        for violation in auditGrader.violations {
            if let index = violation.lineNumber {
                let customLine = Line(lineNumber: index-1, codeString: "// Sample Correction")

                let correction = FileCorrection(fileName: violation.fileName,
                                                lineNumber: index,
                                                customString: nil,
                                                lineInsertions: [customLine],
                                                lineDeletions: nil)
                fileCorrections.append(correction)
            }
        }
        return fileCorrections
    }
}
