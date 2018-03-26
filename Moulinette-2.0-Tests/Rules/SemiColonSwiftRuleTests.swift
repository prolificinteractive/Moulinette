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
    
    func testRun_SemiColonFound() {
        sut = SemiColonSwiftRule(projectData: projectData(fileName: "Sample.swift", line: "let hello = 0;"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_NoSemiColonFound() {
        sut = SemiColonSwiftRule(projectData: projectData(fileName: "Sample.swift", line: "let hello = 0"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }

    func testRun_MiddleSemiColon() {
        sut = SemiColonSwiftRule(projectData: projectData(fileName: "Sample.swift", line: "let hello; = 0"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_DoubleEndSemiColon() {
        sut = SemiColonSwiftRule(projectData: projectData(fileName: "Sample.swift", line: "let hello = 0;;"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_SemiColonInComment() {
        sut = SemiColonSwiftRule(projectData: projectData(fileName: "Sample.swift", line: "// Hello; this is a comment;"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
}
