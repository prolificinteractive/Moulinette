//
//  PrivateVariableSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Lee Pollard  on 7/27/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class PrivateVariableSwiftRule: SwiftRule {
    
    let name: String = "Variable should only be public if required."
    let priority: RulePriority = .high
    
    fileprivate var contextCheck = ContextCheck()
    fileprivate var count = 0
    private var projectData: ProjectData
    
    fileprivate lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        for (fileName, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                contextCheck.check(fileLine: $0)
                
                if publicIBOutletVariablePubliclyUsedCheck(fileLine: $0, fileName: fileName) {
                    print($0)
                    print(fileName)
                    count += 1
                    auditGrader.violationFound(fileName: fileName, description: $0)
                }
            }
        }
        print(count)
        return auditGrader.generateGrade()
    }
}

private extension PrivateVariableSwiftRule {
    
    func publicIBOutletVariablePubliclyUsedCheck(fileLine: String, fileName: String) -> Bool {
        guard isPublicVariable(fileLine: fileLine) else {
            return false
        }
        
        let className = classNameFromFile(fileName: fileName)
        let variableName = variableNameFromLine(fileLine: fileLine)
        
        let publicOccurencesFound = searchForPublicVariable(classNameOfPublicVariable: className,
                                                               variableName: variableName,
                                                               publicVariable: nil)
        
        let isVariableOverriden = isPublicIBOutletVariableOverridden(className: className, variableName: variableName)
        
        return !publicOccurencesFound && !isVariableOverriden
    }
    
    private func isPublicIBOutletVariableOverridden(className: String, variableName: String) -> Bool {
        var numberOfTimesOverriden = 0
        
        for (_, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                if isSubClass(className: className, fileLine: $0) {
                    fileComponents.forEach {
                        if $0.contains(variableName)
                            && $0.contains("override")
                            && $0.contains("var")
                            && $0.contains("IBOutlet") {
                            numberOfTimesOverriden += 1
                        }
                    }
                }
            }
        }
        
        return numberOfTimesOverriden > 0
    }
    
    private func isSubClass(className: String, fileLine: String) -> Bool {
        return fileLine.contains("class") && fileLine.contains(":") && fileLine.contains(className)
    }
    
    private func variableNameFromLine(fileLine: String) -> String {
        let noSpacefileLine = fileLine.stringWithoutWhitespaces()
        
        guard let variableName = noSpacefileLine.stringBetween(startString: "var", endString: ":") else {
            return ""
        }
        
        return variableName
    }
    
    private func classNameFromFile(fileName: String) -> String {
        return fileName.replacingOccurrences(of: ".swift", with: "")
    }
    
    private func searchForPublicVariable(classNameOfPublicVariable: String,
                                         variableName: String,
                                         publicVariable: String?) -> Bool {
        var publicUsesOfVariable = 0
        
        for (_, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                if $0.contains(classNameOfPublicVariable) && $0.contains("var") || $0.contains("@IBOutlet")  {
                    let noSpacefileLine = $0.stringWithoutWhitespaces()
                    guard let classVariableName = noSpacefileLine.stringBetween(startString: "var", endString: ":") else {
                        return
                    }
                    let publicVariable = classVariableName + "." + variableName
                    
                    fileComponents.forEach {
                        if $0.contains(publicVariable) {
                            publicUsesOfVariable += 1
                        }
                    }
                }
            }
        }
        
        return publicUsesOfVariable > 0
    }
    
    private func isPublicVariable(fileLine: String) -> Bool {
        return fileLine.contains("@IBOutlet")
            && !fileLine.contains("private")
            && !fileLine.contains("fileprivate")
            && !fileLine.contains("internal")
            && !fileLine.contains("override")
    }
}
