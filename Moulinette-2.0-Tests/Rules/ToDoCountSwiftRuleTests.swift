//
//  ToDoCountSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/24/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class ToDoCountSwiftRuleTests: XCTestCase {

    var sut: ToDoCountSwiftRule!
    
    
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = ToDoCountSwiftRule(projectData: emptyProjectData())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_EmptySingleFile() {
        sut = ToDoCountSwiftRule(projectData: emptyProjectFile())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
}
