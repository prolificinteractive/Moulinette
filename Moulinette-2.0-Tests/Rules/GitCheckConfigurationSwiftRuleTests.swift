//
//  GitCheckConfigurationSwiftRuleTests.swift
//  Moulinette-2.0-Tests
//
//  Created by Morgan Collino on 12/19/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class GitCheckConfigurationSwiftRuleTests: XCTestCase {
    
    var sut: GitCheckConfigurationSwiftRule!
    
    func test_WithGitIgnore() {
        sut = GitCheckConfigurationSwiftRule(projectData: projectData(fileName: ".gitignore", line: ""))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func test_WithoutGitIgnore() {
        sut = GitCheckConfigurationSwiftRule(projectData: emptyProjectData())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, Int.max)
    }
    
}
