//
//  FinalClassesSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class FinalClassesSwiftRule: CorrectableSwiftRule {
    
    let description = "All classes should be final except when subclassed"
    let nameId = "final_classes"

    let priority: RulePriority = .high
        
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.swiftFiles {
            fileComponents.forEach {
                if $0.isProjectClass(),
                    !$0.contains("final"),
                    let className = $0.className(),
                    !projectData.subClassFound(className: className) {

                    
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
            guard let lineNumber = violation.lineNumber,
                let fileComponents = projectData.applicationComponents.components[violation.fileName],
                let index = violation.componentIndex else {
                    return nil
            }
            let splitClassString = fileComponents[index].split(at: "class")
            let leftString = splitClassString?.leftString == nil ? "" : "\(splitClassString?.leftString ?? "") "
            let customString =  "\(leftString)final class \(splitClassString?.rightString ?? "")"
            return FileCorrection(fileName: violation.fileName,
                                  lineNumber: lineNumber,
                                  customString: customString,
                                  lineInsertions: nil,
                                  lineDeletions: nil)
        })
    }

}
