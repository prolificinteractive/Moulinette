//
//  GitCheckBranchNameSwiftRuleTests.swift
//  Moulinette-Tests
//
//  Created by Morgan Collino on 12/19/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette
class GitCheckBranchNameSwiftRuleTests: XCTestCase {
    
    var sut: FakeGitCheckBranchNameSwiftRule!
    
    func test_NormalGitBranches() {
        sut = FakeGitCheckBranchNameSwiftRule()
        sut.openedBranches = ["origin/develop", "origin/master", "origin/beta",
                              "origin/feature/one", "origin/chore/two", "origin/bugfix/three",
                              "origin/rc/old"]
        
        let grade = sut.run(projectData: emptyProjectData())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func test_NonUsualGitBranches() {
        sut = FakeGitCheckBranchNameSwiftRule()
        sut.openedBranches = ["origin/develop", "origin/master", "origin/beta", "origin/chore/test", "origin/feature/moulinette", "origin/bugfix/test", "origin/whatever", "hello/from/the/other/side", "origin/davechapelle_show_2018"]
        
        let grade = sut.run(projectData: emptyProjectData())
        
        XCTAssertEqual(grade.violationCount, 3)
    }
    
}

class FakeGitCheckBranchNameSwiftRule: GitCheckBranchNameSwiftRule {
    
    var openedBranches: [String]?
    
    override func getOpenedBranches() throws -> [String]? {
        return openedBranches
    }
    
}
