//
//  SinglePublicInternalSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class SinglePublicInternalSwiftRuleTests: XCTestCase {

    var sut: SinglePublicInternalSwiftRule!
    
    func testRun_SingleTypeClass() {
        sut = SinglePublicInternalSwiftRule(projectData: projectData(line: "class SampleClass {}"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_SingleTypeEnum() {
        sut = SinglePublicInternalSwiftRule(projectData: projectData(line: "enum {}"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_SingleTypeProtocol() {
        sut = SinglePublicInternalSwiftRule(projectData: projectData(line: "protocol SampleProtocol {}"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_SingleTypeStruct() {
        sut = SinglePublicInternalSwiftRule(projectData: projectData(line: "struct SampleStruct {}"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_ConstantsFile() {
        sut = SinglePublicInternalSwiftRule(projectData: projectData(fileName: "Constants", line: "struct Constants"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
}
