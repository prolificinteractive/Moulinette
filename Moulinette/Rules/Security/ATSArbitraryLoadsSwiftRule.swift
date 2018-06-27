//
//  ATSArbitraryLoadsSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/27/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

/// Check to see if there are any exception domains in the NSAppTransportSecurity key in the Info.plists.
final class ATSArbitraryLoadsSwiftRule: SwiftRule {

    let description = "Check if the app allows arbitrary loads in the targets' Info.plists."
    let nameId = "ats_arbitrary_loads"

    let priority: RulePriority = .high

    private let appTransportSecurityString = "NSAppTransportSecurity"
    private let arbirtraryLoadsString = "NSAllowsArbitraryLoads"
    private let supportingFilesString = "/Supporting Files/"

    private lazy var auditGrader: AuditGrader = {
        return PIOSAuditGrader(priority: self.priority)
    }()

    func run(projectData: ProjectData) -> AuditGrade {
        let plistFiles = projectData.applicationComponents.files(for: Constants.FileNameConstants.plistSuffix)

        plistFiles.forEach { (fileName, fileComponents) in
            if let plistXMLDictionary = ProjectXMLParser.parse(xml: fileComponents),
                let appTransportValue = plistXMLDictionary[appTransportSecurityString] as? [String : Any],
                let arbirtraryLoads = appTransportValue[arbirtraryLoadsString] as? Bool,
                arbirtraryLoads {

                auditGrader.violationFound(fileName: fileName,
                                           lineNumber: nil,
                                           description: "Arbitrary Loads Allowed! Check info.plist",
                                           nameId: nameId)
            }
        }

        return auditGrader.generateGrade()
    }
}
