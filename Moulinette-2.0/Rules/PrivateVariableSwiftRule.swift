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
            
            var protocolsAndSubclassesInFile: [String]?
            
            if let protocolsAndSubclasses = fileProtocolsAndSubclasses(fileComponents: fileComponents) {
                protocolsAndSubclassesInFile = protocolsAndSubclasses
            }
            
            fileComponents.forEach {
                contextCheck.check(fileLine: $0)
                
                if publicIBOutletVariablePubliclyUsedCheck(fileLine: $0,
                                                           fileName: fileName,
                                                           protocolsAndSubClassesInFile: protocolsAndSubclassesInFile) {
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
    
    func publicIBOutletVariablePubliclyUsedCheck(fileLine: String,
                                                 fileName: String,
                                                 protocolsAndSubClassesInFile: [String]?) -> Bool {
        guard isPublicVariable(fileLine: fileLine) else {
            return false
        }
        
        let className = classNameFromFile(fileName: fileName)
        let noSpacefileLine = fileLine.stringWithoutWhitespaces()
        let variableName = variableNameStringBetween(noSpacefileLine: noSpacefileLine,
                                                     endString: Constants.SwiftComponents.colonString)
        
        let didFindPublicOccurrences = publicOccurrencesFound(classNameOfPublicVariable: className,
                                                              variableName: variableName)
        
        let isVariableOverriden = isPublicIBOutletVariableOverridden(className: className, variableName: variableName)
        
        let isProtocolVariable = isPublicIBOutletProtocolVariable(variableName: variableName,
                                                                  protocolsAndSubClassesInFile: protocolsAndSubClassesInFile)
        
        return !didFindPublicOccurrences && !isVariableOverriden && !isProtocolVariable
    }
    
    func fileProtocolsAndSubclasses(fileComponents: [String]) -> [String]? {
        var fileComponentsArray = fileComponents.joined().components(separatedBy: " ")
        
        guard let classIndex = fileComponentsArray.index(of: Constants.SwiftComponents.classString) else {
            return nil
        }
        
        fileComponentsArray.replaceSubrange(0..<classIndex, with: [])
        
        let fileComponentsString = fileComponentsArray.joined(separator: " ")
        
        guard let protocolAndSubclassesString = fileComponentsString.stringBetween(startString: Constants.SwiftComponents.classString,
                                                                          endString: Constants.SwiftComponents.openCurlyBracketString) else {
            return nil
        }
        
        let protocolsNoCommas = protocolAndSubclassesString.replacingOccurrences(of: ",", with: "")
        let protocolAndSubclassesArray = protocolsNoCommas.components(separatedBy: " ")
        let protocolArrayNoSpace = protocolAndSubclassesArray.filter {
            return $0 != ""
        }
        
        return protocolArrayNoSpace
    }
    
    private func isPublicIBOutletProtocolVariable(variableName: String, protocolsAndSubClassesInFile: [String]?) -> Bool {
        guard let protocolsAndSubClassesInFile = protocolsAndSubClassesInFile else {
            return false
        }
        
        var numberOfProtocolVariables = 0
        
        protocolsAndSubClassesInFile.forEach { (protocolName) in
            for (fileName, fileComponents) in projectData.applicationComponents.components {
                let fileClassName = fileName.replacingOccurrences(of: Constants.FileNameConstants.swiftDotSuffix, with: "")
                if fileClassName == protocolName {
                    fileComponents.forEach {
                        if $0.contains(variableName) {
                            numberOfProtocolVariables += 1
                        }
                    }
                }
            }
        }
        
        return numberOfProtocolVariables > 0
    }
    
    private func isPublicIBOutletVariableOverridden(className: String, variableName: String) -> Bool {
        var numberOfTimesOverriden = 0
        
        for (_, fileComponents) in projectData.applicationComponents.components {
            fileComponents.forEach {
                if isSubClass(className: className, fileLine: $0) {
                    fileComponents.forEach {
                        if $0.contains(variableName)
                            && $0.contains(Constants.SwiftComponents.overrideString)
                            && $0.contains(Constants.SwiftComponents.varString) {
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
                if $0.contains(classNameOfPublicVariable) &&
                    ($0.contains(Constants.SwiftComponents.varString) || $0.contains(Constants.SwiftComponents.letString)) {
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
        var noSpacefileLineArray = noSpacefileLine.characters.map {
            String($0)
        }
        
        guard let equalsIndex = noSpacefileLineArray.index(of: Constants.SwiftComponents.equalString) else {
            let variableName = variableNameStringBetween(noSpacefileLine: noSpacefileLine,
                                                         endString: Constants.SwiftComponents.colonString)
            return variableName
        }
        
        noSpacefileLineArray.replaceSubrange(equalsIndex..<noSpacefileLineArray.count, with: [])
        
        let variableNameFromLine = extractVariableNameFrom(array: noSpacefileLineArray, noSpacefileLine: noSpacefileLine)
        
        return variableNameFromLine
    }
    
    private func extractVariableNameFrom(array: [String],
                                         noSpacefileLine: String) -> String {
        var variableNameFromLine = ""
        
        if let _ = array.index(of: Constants.SwiftComponents.colonString) {
            variableNameFromLine = variableNameStringBetween(noSpacefileLine: noSpacefileLine,
                                      endString: Constants.SwiftComponents.colonString)
        } else {
            variableNameFromLine = variableNameStringBetween(noSpacefileLine: noSpacefileLine,
                                      endString: Constants.SwiftComponents.equalString)
        }
        
        return variableNameFromLine
    }
    
    private func variableNameStringBetween(noSpacefileLine: String,
                                           endString: String) -> String {
        var variableNameFromLine = ""
        
        if let variableName = noSpacefileLine.stringBetween(startString: Constants.SwiftComponents.varString,
                                                            endString: endString) {
            variableNameFromLine = variableName
        } else if let variableName = noSpacefileLine.stringBetween(startString: Constants.SwiftComponents.letString,
                                                              endString: endString) {
            variableNameFromLine = variableName
        }
        
        return variableNameFromLine
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
        return fileLine.contains(Constants.SwiftComponents.varString)
            && !fileLine.contains(Constants.SwiftComponents.privateString)
            && !fileLine.contains(Constants.SwiftComponents.fileprivateString)
            && !fileLine.contains(Constants.SwiftComponents.internalString)
            && !fileLine.contains(Constants.SwiftComponents.overrideString)
            && !fileLine.contains(Constants.SwiftComponents.getString)
    }
}
