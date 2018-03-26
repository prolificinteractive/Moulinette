//
//  CocoapodsKeysSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class CocoapodsKeysSwiftRuleTests: XCTestCase {

    var sut: CocoapodsKeysSwiftRule!
    
    func testRun_CocoapodsKeysFound() {
        sut = CocoapodsKeysSwiftRule(projectData: projectData(fileName: "Sample", line: "import Keys"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_CocoapodsKeysNotFound() {
        sut = CocoapodsKeysSwiftRule(projectData: projectData(fileName: "Sample", line: "import Keychain"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, Int.max)
    }
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = CocoapodsKeysSwiftRule(projectData: emptyProjectData())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_EmptySingleFile() {
        sut = CocoapodsKeysSwiftRule(projectData: emptyProjectFile())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, Int.max)
    }
}
