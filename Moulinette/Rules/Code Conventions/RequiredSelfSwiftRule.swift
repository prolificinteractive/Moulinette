//
//  RequiredSelfSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class RequiredSelfSwiftRule: SwiftRule {
    
    static fileprivate let selfString = "self."
    
    let description = "Use of self only when required"
    let nameId = "required_self"

    let priority: RulePriority = .medium
    
    fileprivate var contextCheck = ContextCheck()
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                contextCheck.check(fileLine: $0)
                
                if variableSetCheck(fileLine: $0, fileName: fileName)
                    || functionSelfCheck(fileLine: $0, fileName: fileName) {
                    auditGrader.violationFound(fileName: fileName, lineNumber: fileComponents.lineNumberFor($0), description: description, nameId: nameId)
                }
            }
        }
        return auditGrader.generateGrade()
    }
}

private extension RequiredSelfSwiftRule {
    
    func functionSelfCheck(fileLine: String, fileName: String) -> Bool {
        guard contextCheck.currentContext == .function else {
            return false
        }
        
        return fileLine.contains(RequiredSelfSwiftRule.selfString)
    }
    
    func variableSetCheck(fileLine: String, fileName: String) -> Bool {
        guard validContext() else {
            return false
        }
        
        if fileLine.contains(RequiredSelfSwiftRule.selfString) {
            let line = fileLine.replacingOccurrences(of: RequiredSelfSwiftRule.selfString, with: "")
            
            if let splitString = line.split(at: " = "), !splitString.rightString.contains(splitString.leftString) {
                return true
            }
        }
        return false
    }
    
    func validContext() -> Bool {
        if contextCheck.insideContext(type: .lazy) || contextCheck.insideContext(type: .dispatchMain) {
            return false
        }
        return true
    }
}
