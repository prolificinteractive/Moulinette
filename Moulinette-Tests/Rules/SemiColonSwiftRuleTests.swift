//
//  SemiColonSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class SemiColonSwiftRuleTests: XCTestCase {

    var sut: SemiColonSwiftRule!
    
    /// Semicolon test.
    func testRun_SemiColonFound() {
        sut = SemiColonSwiftRule(projectData: projectData(line: "let hello = 0;"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 1)
    }
    
    /// No semicolon found test.
    func testRun_NoSemiColonFound() {
        sut = SemiColonSwiftRule(projectData: projectData(line: "let hello = 0"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }

    func testRun_MiddleSemiColon() {
        sut = SemiColonSwiftRule(projectData: projectData(line: "let hello; = 0"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_DoubleEndSemiColon() {
        sut = SemiColonSwiftRule(projectData: projectData(line: "let hello = 0;;"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 1)
    }
}

private extension SemiColonSwiftRuleTests {
    
    func projectData(line: String) -> ProjectData {
        let applicationComponents = ApplicationComponents(with: ["Sample": [line]])
        return ProjectData(applicationComponents: applicationComponents)
    }
}
