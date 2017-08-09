//
//  ATSExceptionSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Lee Pollard  on 8/9/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class ATSExceptionSwiftRuleTests: XCTestCase {
    
    var sut: ATSExceptionSwiftRule!
    
    func testATSExceptionSwiftRuleTests_ExceptionFound() {
        sut = atsExceptionSwiftRule(fileName: "ExceptionDomains.plist")
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 1)
    }
    
    func testATSExceptionSwiftRuleTests_NoExceptionFound() {
        sut = atsExceptionSwiftRule(fileName: "NoExceptionDomains.plist")
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
}

private extension ATSExceptionSwiftRuleTests {
    
    func atsExceptionSwiftRule(fileName: String) -> ATSExceptionSwiftRule {
        let rule = ATSExceptionSwiftRule(projectData: projectData(fileName: fileName))
        rule.plistPath = "/Users/leepollard/Documents/Prolific_Repos/PiOS/Moulinette-2.0-Tests/"
        return rule
    }
    
    func projectData(fileName: String) -> ProjectData {
        let applicationComponents = ApplicationComponents(with: [fileName: []])
        return ProjectData(applicationComponents: applicationComponents)
    }
}
