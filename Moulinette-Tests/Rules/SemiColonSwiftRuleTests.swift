//
//  SemiColonSwiftRuleTests.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette
class SemiColonSwiftRuleTests: XCTestCase {

    var sut: SemiColonSwiftRule!
    
    func testRun_SemiColonFound() {
        sut = SemiColonSwiftRule()
        
        let grade = sut.run(projectData: projectData(fileName: "Sample.swift", line: "let hello = 0;"))
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_NoSemiColonFound() {
        sut = SemiColonSwiftRule()
        
        let grade = sut.run(projectData: projectData(fileName: "Sample.swift", line: "let hello = 0"))
        
        XCTAssertEqual(grade.violationCount, 0)
    }

    func testRun_MiddleSemiColon() {
        sut = SemiColonSwiftRule()
        
        let grade = sut.run(projectData: projectData(fileName: "Sample.swift", line: "let hello; = 0"))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_DoubleEndSemiColon() {
        sut = SemiColonSwiftRule()
        
        let grade = sut.run(projectData: projectData(fileName: "Sample.swift", line: "let hello = 0;;"))
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_SemiColonInComment() {
        sut = SemiColonSwiftRule()
        
        let grade = sut.run(projectData: projectData(fileName: "Sample.swift", line: "// Hello; this is a comment;"))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
}
