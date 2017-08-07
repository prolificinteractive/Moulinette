//
//  ATSExceptionSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Lee Pollard  on 8/7/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Check to see if there are any exception domains in the NSAppTransportSecurity key in the Info.plists.
final class ATSExceptionSwiftRule: SwiftRule {
    
    let name: String = "Check if there are any ATS exception domain in the targets' Info.plists."
    let priority: RulePriority = .medium
    
    fileprivate var contextCheck = ContextCheck()
    private var projectData: ProjectData
    
    private let appTransportSecurityString = "NSAppTransportSecurity"
    private let exceptionDomainsString = "NSExceptionDomains"
    private let supportingFilesString = "/Supporting Files/"
    
    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> AuditGrade {
        let plistFiles = projectData.applicationComponents.files(for: Constants.FileNameConstants.plistSuffix)
        
        plistFiles.forEach { (fileName, _) in
            let plistPath = settings.projectDirectory + supportingFilesString + fileName
            let plistXMLDictionary: [String : AnyObject]? = plistPath.parsedXMLDictionary()
            
            if let plistXMLDictionary = plistXMLDictionary,
                let appTransportValue = plistXMLDictionary[appTransportSecurityString],
                let exceptionDomains = appTransportValue[exceptionDomainsString] as? [String : Any],
                exceptionDomains.count > 0  {
                auditGrader.violationFound(fileName: fileName, description: "Exception Domains found")
            }
        }
        
        return auditGrader.generateGrade()
    }
}
