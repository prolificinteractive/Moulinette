//
//  CocoapodsKeysSwiftRuleTests.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette
class CocoapodsKeysSwiftRuleTests: XCTestCase {

    var sut: CocoapodsKeysSwiftRule!
    
    func testRun_CocoapodsKeysFound() {
        sut = CocoapodsKeysSwiftRule()
        
        let grade = sut.run(projectData: projectData(fileName: "Podfile", line: "plugin 'cocoapods-keys'"))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_CocoapodsKeysNotFound() {
        sut = CocoapodsKeysSwiftRule()
        
        let grade = sut.run(projectData: projectData(fileName: "Podfile", line: ""))
        
        XCTAssertEqual(grade.violationCount, Int.max)
    }
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = CocoapodsKeysSwiftRule()
        
        let grade = sut.run(projectData: emptyProjectData())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_EmptySingleFile() {
        sut = CocoapodsKeysSwiftRule()
        
        let grade = sut.run(projectData: emptyProjectFile())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
}
