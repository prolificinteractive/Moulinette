//
//  SwiftLintSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/15/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class SwiftLintSwiftRuleTests: XCTestCase {

    var sut: SwiftLintSwiftRule!

    func testRun_SwiftLintBuildPhase() {
        sut = SwiftLintSwiftRule(projectData: swiftLintBuildPhase())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.score(), sut.priority.weight())
    }
    
    func testRun_SwiftLintAbsentBuildPhase() {
        sut = SwiftLintSwiftRule(projectData: swiftLintAbsentBuildPhase())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.score(), 0.0)
    }
}

private extension SwiftLintSwiftRuleTests {
    
    func swiftLintBuildPhase() -> ProjectData {
        let fileComponents = ["${PODS_ROOT}/SwiftLint/swiftlint"]
        
        return ProjectData(applicationComponents: ApplicationComponents(with: [Constants.FileNameConstants.xcodeProject : fileComponents]))
    }
    
    func swiftLintAbsentBuildPhase() -> ProjectData {
        let fileComponents = ["Empty project"]
        
        return ProjectData(applicationComponents: ApplicationComponents(with: [Constants.FileNameConstants.xcodeProject : fileComponents]))
    }
}