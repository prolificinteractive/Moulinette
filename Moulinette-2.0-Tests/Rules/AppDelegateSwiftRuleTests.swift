//
//  AppDelegateSwiftRuleTests.swift
//  Moulinette
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
        let applicationComponents = ApplicationComponents(with: [""])
        let data = ProjectData(path: "", applicationComponents: applicationComponents)
        sut = AppDelegateSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertTrue(grade.gradeType.gradeText().contains("No App Delegate Found!!!"))
    }
    
    func testRun_ShortAppDelegate() {
        let data = ProjectData(path: "", applicationComponents: emptyFile(length: 30))
        sut = AppDelegateSwiftRule()
        
        let grade = sut.run(projectData: data)

        XCTAssertEqual(grade.gradeType.gradeText(), GradeType.pass.gradeText())
    }
    
    func testRun_LongAppDelegate() {
        let data = ProjectData(path: "", applicationComponents: emptyFile(length: 300))
        sut = AppDelegateSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertTrue(grade.gradeType.gradeText().contains("Line Count Above 80, Actual: "))
    }
}

extension AppDelegateSwiftRuleTests {
    
    func emptyFile(length: Int) -> ApplicationComponents {
        var file = [""]
        for _ in 0..<length {
            file.append("Hello")
        }
        return ApplicationComponents(with: ["AppDelegate.swift": file])
    }
}
