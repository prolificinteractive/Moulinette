//
//  SinglePublicInternalSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class SinglePublicInternalSwiftRule: SwiftRule {
    
    let description = "One public/internal type per file (class, enum, protocol, struct)"
    let nameId = "one_type_per_file"

    let priority: RulePriority = .low
    
    private var type: FileType?
    private var commentCheck = OldCommentStyleCheck()
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.swiftFiles {
            fileComponents.forEach {
                commentCheck.check(line: $0)
                if !commentCheck.insideCommentContext, let fileType = FileType.type(fileLine: $0) {
                    if let type = type,
                        !$0.isComment(),
                        !fileName.contains("Constants") && !$0.contains("CodingKey") {
                        let firstValue = FileType.value(fileType: type)
                        let secondValue = FileType.value(fileType: fileType)
                        
                        auditGrader.violationFound(fileName: fileName,
                                                   lineNumber: fileComponents.lineNumberFor($0),
                                                   description: "\(firstValue.capitalized) and a \(secondValue) present in the same file.",
                                                   nameId: nameId)
                    }
                    type = fileType
                }
            }
            type = nil
        }
        return auditGrader.generateGrade()
    }
}
