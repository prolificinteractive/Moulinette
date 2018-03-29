//
//  AppIconSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class AppIconSwiftRuleTests: XCTestCase {

    var sut: AppIconSwiftRule!
    
    func testRun_AppIconConfigurationUsed() {
        let data = projectData(fileName: Constants.FileNameConstants.xcodeProject,
                               line: "ASSETCATALOG_COMPILER_APPICON_NAME = \"AppIcon\"")
        sut = AppIconSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_AppIconConfigurationNotSet() {
        let data = projectData(fileName: Constants.FileNameConstants.xcodeProject,
                               line: "ASSETCATALOG_COMPILER_APPICON_NAME = \"\"")
        sut = AppIconSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = AppIconSwiftRule()
        
        let grade = sut.run(projectData: emptyProjectData())
        
        XCTAssertEqual(grade.violationCount, Int.max)
    }
    
    func testRun_EmptySingleFile() {
        sut = AppIconSwiftRule()
        
        let grade = sut.run(projectData: emptyProjectFile())
        
        XCTAssertEqual(grade.violationCount, Int.max)
    }
}
