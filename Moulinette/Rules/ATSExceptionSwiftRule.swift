//
//  ATSExceptionSwiftRule.swift
//  Moulinette
//
//  Created by Lee Pollard  on 8/7/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Check to see if there are any exception domains in the NSAppTransportSecurity key in the Info.plists.
final class ATSExceptionSwiftRule: SwiftRule {
    
    let description = "Check if there are any ATS exception domain in the targets' Info.plists."
    let nameId = "ats_exception"

    let priority: RulePriority = .medium
    
    /// The path of the plist files. Made public for testing.
    lazy var plistPath: String = {
        return settings.projectDirectory + self.supportingFilesString
    }()
    
    fileprivate var contextCheck = ContextCheck()
    
    private let appTransportSecurityString = "NSAppTransportSecurity"
    private let exceptionDomainsString = "NSExceptionDomains"
    private let supportingFilesString = "/Supporting Files/"
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    func run(projectData: ProjectData) -> AuditGrade {
        let plistFiles = projectData.applicationComponents.files(for: Constants.FileNameConstants.plistSuffix)
        
        plistFiles.forEach { (fileName, fileComponents) in
            if let plistXMLDictionary = ProjectXMLParser.parse(xml: fileComponents),
                let appTransportValue = plistXMLDictionary[appTransportSecurityString] as? [String : Any],
                let exceptionDomains = appTransportValue[exceptionDomainsString] as? [String : Any],
                exceptionDomains.count > 0  {

                let exceptions = exceptionDomains.map { $0.key }.joined(separator: ",")
                auditGrader.violationFound(fileName: fileName,
                                           lineNumber: nil,
                                           description: "Exception Domains found: \(exceptions)",
                                           nameId: nameId)
            }
        }
        
        return auditGrader.generateGrade()
    }
}
