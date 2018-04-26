//
//  MarkUsageSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class MarkUsageSwiftRule: SwiftRule {
    
    let description: String = "Consistent usage of MARK / TODO"
    let nameId = "mark_usage"

    let priority: RulePriority = .low
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                if consistentMark(fileLine: $0) || consistentTodo(fileLine: $0) {
                    auditGrader.violationFound(fileName: fileName, lineNumber: fileComponents.lineNumberFor($0), description: description, nameId: nameId)
                }
            }
        }
        return auditGrader.generateGrade()
    }
}

private extension MarkUsageSwiftRule {
    
    func consistentMark(fileLine: String) -> Bool {
        let fileLineUppercase = fileLine.uppercased()
        return fileLineUppercase.contains("//")
            && fileLineUppercase.contains("MARK ")
            && !fileLine.contains("// MARK - ")
            && !fileLineUppercase.contains("///")
    }
    
    func consistentTodo(fileLine: String) -> Bool {
        let fileLineUppercase = fileLine.uppercased()
        return fileLineUppercase.contains("//") && fileLineUppercase.contains("TODO ") && !fileLine.contains("// TODO:")
    }
}
