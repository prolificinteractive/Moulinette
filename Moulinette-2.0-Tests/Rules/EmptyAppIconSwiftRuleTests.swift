//
//  EmptyAppIconSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class EmptyAppIconSwiftRuleTests: XCTestCase {

    var sut: EmptyAppIconSwiftRule!
    
    func testRun_SizeFoundNoFileName() {
        let projectData = emptyProjectData()
        projectData.applicationComponents.assets = ["AppIcons-Dev/Contents.json": ["\"size\" : \"60x60\",",
                                                                                   "\"size\" : \"60x60\","]]
        sut = EmptyAppIconSwiftRule(projectData: projectData)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 2)
    }
    
    func testRun_SizeFoundFileNameFound() {
        let projectData = emptyProjectData()
        projectData.applicationComponents.assets = ["AppIcons-Dev/Contents.json": ["\"size\" : \"60x60\",",
                                                                                   "\"filename\" : \"Icon-App-29x29@3x.png\","]]
        sut = EmptyAppIconSwiftRule(projectData: projectData)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_MultipleSizeFoundSingleFileNameFound() {
        let projectData = emptyProjectData()
        projectData.applicationComponents.assets = ["AppIcons-Dev/Contents.json": ["\"size\" : \"60x60\",",
                                                                                   "\"filename\" : \"Icon-App-60x60@3x.png\",",
                                                                                   "\"size\" : \"60x60\","]]
        sut = EmptyAppIconSwiftRule(projectData: projectData)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 1)
    }
    
    func testRun_NoAppIcons() {
        sut = EmptyAppIconSwiftRule(projectData: projectData(fileName: "Sample", line: "class Hello {}"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = EmptyAppIconSwiftRule(projectData: emptyProjectData())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_EmptySingleFile() {
        sut = EmptyAppIconSwiftRule(projectData: emptyProjectFile())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
}
