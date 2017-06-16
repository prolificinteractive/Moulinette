//
//  AppDelegateSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class AppDelegateSwiftRuleTests: XCTestCase {

    var sut: AppDelegateSwiftRule!
    
    override func setUp() {
        super.setUp()
    }
    
    func testRun_NoAppDelegate() {
        let data = ProjectData(applicationComponents: ["": [""]])
        sut = AppDelegateSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertTrue(grade.gradeType.gradeText().contains("No App Delegate Found!!!"))
    }
    
    func testRun_ShortAppDelegate() {
        let data = ProjectData(applicationComponents: file(length: 30))
        sut = AppDelegateSwiftRule(projectData: data)
        
        let grade = sut.run()

        XCTAssertEqual(grade.gradeType.gradeText(), GradeType.pass.gradeText())
    }
    
    func testRun_LongAppDelegate() {
        let data = ProjectData(applicationComponents: file(length: 300))
        sut = AppDelegateSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertTrue(grade.gradeType.gradeText().contains("Line Count Above 80, Actual: "))
    }
}

extension AppDelegateSwiftRuleTests {
    
    func file(length: Int) -> ApplicationComponents {
        var file = [""]
        for _ in 0..<length {
            file.append("Hello")
        }
        return ["AppDelegate.swift": file]
    }
}
