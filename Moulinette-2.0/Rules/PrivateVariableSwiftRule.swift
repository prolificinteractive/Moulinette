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
        
        let didFindPublicOccurrences = publicOccurrencesFound(classNameOfPublicVariable: className,
                                                               variableName: variableName)
        
        let isVariableOverriden = isPublicIBOutletVariableOverridden(className: className, variableName: variableName)
        
        return !didFindPublicOccurrences && !isVariableOverriden
    }
    
    private func isPublicIBOutletVariableOverridden(className: String, variableName: String) -> Bool {
        var numberOfTimesOverriden = 0
        
        for (_, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                if isSubClass(className: className, fileLine: $0) {
                    fileComponents.forEach {
                        if $0.contains(variableName)
                            && $0.contains(Constants.SwiftComponents.overrideString)
                            && $0.contains(Constants.SwiftComponents.varString)
                            && $0.contains(Constants.SwiftComponents.ibOutletString) {
                            numberOfTimesOverriden += 1
                        }
                    }
                }
            }
        }
        
        return numberOfTimesOverriden > 0
    }
    
    private func publicOccurrencesFound(classNameOfPublicVariable: String,
                                         variableName: String) -> Bool {
        var publicUsesOfVariable = 0
        
        for (_, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                if $0.contains(classNameOfPublicVariable) && $0.contains(Constants.SwiftComponents.varString)
                    || $0.contains(Constants.SwiftComponents.ibOutletString)  {
                    let classVariableName = variableNameFromLine(fileLine: $0)
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
    
    private func variableNameFromLine(fileLine: String) -> String {
        let noSpacefileLine = fileLine.stringWithoutWhitespaces()
        
        guard let variableName = noSpacefileLine.stringBetween(startString: Constants.SwiftComponents.varString,
                                                               endString: Constants.SwiftComponents.colonString) else {
                                                                return ""
        }
        
        return variableName
    }
    
    private func classNameFromFile(fileName: String) -> String {
        return fileName.replacingOccurrences(of: Constants.FileNameConstants.swiftDotSuffix, with: "")
    }
    
    private func isSubClass(className: String, fileLine: String) -> Bool {
        return fileLine.contains(Constants.SwiftComponents.classString)
            && fileLine.contains(Constants.SwiftComponents.colonString)
            && fileLine.contains(className)
    }
    
    private func isPublicVariable(fileLine: String) -> Bool {
        return fileLine.contains(Constants.SwiftComponents.ibOutletString)
            && !fileLine.contains(Constants.SwiftComponents.privateString)
            && !fileLine.contains(Constants.SwiftComponents.fileprivateString)
            && !fileLine.contains(Constants.SwiftComponents.internalString)
            && !fileLine.contains(Constants.SwiftComponents.overrideString)
    }
}
