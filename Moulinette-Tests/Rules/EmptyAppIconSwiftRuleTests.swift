//
//  EmptyAppIconSwiftRuleTests.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette
class EmptyAppIconSwiftRuleTests: XCTestCase {

    var sut: EmptyAppIconSwiftRule!
    
    func testRun_SizeFoundNoFileName() {
        let projectData = emptyProjectData()
        projectData.applicationComponents.assets = ["AppIcons-Dev/Contents.json": ["\"size\" : \"60x60\",",
                                                                                   "\"size\" : \"60x60\","]]
        sut = EmptyAppIconSwiftRule()
        
        let grade = sut.run(projectData: projectData)
        
        XCTAssertEqual(grade.violationCount, 2)
    }
    
    func testRun_SizeFoundFileNameFound() {
        let projectData = emptyProjectData()
        projectData.applicationComponents.assets = ["AppIcons-Dev/Contents.json": ["\"size\" : \"60x60\",",
                                                                                   "\"filename\" : \"Icon-App-60x60@3x.png\",",
                                                                                   "\"size\" : \"60x60\",",
                                                                                   "\"filename\" : \"Icon-App-60x60@3x.png\","]]
        sut = EmptyAppIconSwiftRule()
        
        let grade = sut.run(projectData: projectData)
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_MultipleSizeFoundSingleFileNameFound() {
        let projectData = emptyProjectData()
        projectData.applicationComponents.assets = ["AppIcons-Dev/Contents.json": ["\"size\" : \"60x60\",",
                                                                                   "\"filename\" : \"Icon-App-60x60@3x.png\",",
                                                                                   "\"size\" : \"60x60\","]]
        sut = EmptyAppIconSwiftRule()
        
        let grade = sut.run(projectData: projectData)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_NoAppIcons() {
        sut = EmptyAppIconSwiftRule()
        
        let grade = sut.run(projectData: projectData(fileName: "Sample", line: "class Hello {}"))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = EmptyAppIconSwiftRule()
        
        let grade = sut.run(projectData: emptyProjectData())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_EmptySingleFile() {
        sut = EmptyAppIconSwiftRule()
        
        let grade = sut.run(projectData: emptyProjectFile())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
}
