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
        sut = TypeInferenceSwiftRule()
        
        let grade = sut.run(projectData: projectData(line: "var sample = Example()"))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func test_RunUnnecessaryTypeInitialize() {
        sut = TypeInferenceSwiftRule()
        
        let grade = sut.run(projectData: projectData(line: "var sample: Example = Example()"))
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func test_RunCorrectTypeStringInitialize() {
        sut = TypeInferenceSwiftRule()
        
        let grade = sut.run(projectData: projectData(line: "var sample = \"\""))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func test_RunUnnecessaryTypeStringInitialize() {
        sut = TypeInferenceSwiftRule()
        
        let grade = sut.run(projectData: projectData(line: "var sample: String = \"\""))
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = TypeInferenceSwiftRule()
        
        let grade = sut.run(projectData: emptyProjectData())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_EmptySingleFile() {
        sut = TypeInferenceSwiftRule()
        
        let grade = sut.run(projectData: emptyProjectFile())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
}
