//
//  TypeInferenceSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 9/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class TypeInferenceSwiftRuleTests: XCTestCase {

    var sut: TypeInferenceSwiftRule!
    
    func test_RunCorrectTypeInitialize() {
        sut = TypeInferenceSwiftRule(projectData: projectData(line: "var sample = Example()"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func test_RunUnnecessaryTypeInitialize() {
        sut = TypeInferenceSwiftRule(projectData: projectData(line: "var sample: Example = Example()"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func test_RunCorrectTypeStringInitialize() {
        sut = TypeInferenceSwiftRule(projectData: projectData(line: "var sample = \"\""))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func test_RunUnnecessaryTypeStringInitialize() {
        sut = TypeInferenceSwiftRule(projectData: projectData(line: "var sample: String = \"\""))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = TypeInferenceSwiftRule(projectData: emptyProjectData())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_EmptySingleFile() {
        sut = TypeInferenceSwiftRule(projectData: emptyProjectFile())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
}
