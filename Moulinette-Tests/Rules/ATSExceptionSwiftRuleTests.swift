//
//  ATSExceptionSwiftRuleTests.swift
//  Moulinette
//
//  Created by Lee Pollard  on 8/9/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette
class ATSExceptionSwiftRuleTests: XCTestCase {
    
    var sut: ATSExceptionSwiftRule!
    
    func testATSExceptionSwiftRuleTests_ExceptionFound() {
        sut = atsExceptionSwiftRule()
        
        let grade = sut.run(projectData: projectData(fileName: "ExceptionDomains.plist"))
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testATSExceptionSwiftRuleTests_NoExceptionFound() {
        sut = atsExceptionSwiftRule()
        
        let grade = sut.run(projectData: projectData(fileName: "NoExceptionDomains.plist"))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
}

private extension ATSExceptionSwiftRuleTests {
    
    func atsExceptionSwiftRule() -> ATSExceptionSwiftRule {
        let rule = ATSExceptionSwiftRule()
        
        // The location of the two test plists on your machine.
        let moulinetteBundles = Bundle.allBundles.filter { $0.bundlePath.contains(Constants.FileNameConstants.moulinetteName) }
        if let firstBundle = moulinetteBundles.first, let resourcePath = firstBundle.resourcePath {
            rule.plistPath = resourcePath + "/"
        }
        
        return rule
    }
    
    func projectData(fileName: String) -> ProjectData {
        let applicationComponents = ApplicationComponents(with: [fileName: []])
        return ProjectData(path: "", applicationComponents: applicationComponents)
    }
}
