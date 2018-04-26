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
        sut = AppIconSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_AppIconConfigurationNotSet() {
        let data = projectData(fileName: Constants.FileNameConstants.xcodeProject,
                               line: "ASSETCATALOG_COMPILER_APPICON_NAME = \"\"")
        sut = AppIconSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 1)
    }
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = AppIconSwiftRule(projectData: emptyProjectData())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, Int.max)
    }
    
    func testRun_EmptySingleFile() {
        sut = AppIconSwiftRule(projectData: emptyProjectFile())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, Int.max)
    }
}
