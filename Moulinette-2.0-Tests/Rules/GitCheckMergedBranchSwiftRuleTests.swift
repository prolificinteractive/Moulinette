//
//  GitCheckMergedBranchSwiftRuleTests.swift
//  Moulinette-2.0-Tests
//
//  Created by Morgan Collino on 12/19/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class GitCheckMergedBranchSwiftRuleTests: XCTestCase {
    
    var sut: FakeGitCheckMergedBranchSwiftRule!
    
    func test_NormalGitBranches() {
        sut = FakeGitCheckMergedBranchSwiftRule()
        sut.mergedBranches = ["origin/develop", "origin/master", "origin/beta"]
        
        let grade = sut.run(projectData: emptyProjectData())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func test_NonUsualGitBranches() {
        sut = FakeGitCheckMergedBranchSwiftRule()
        sut.mergedBranches = ["origin/develop", "origin/master", "origin/beta", "origin/chore/test", "origin/feature/moulinette", "origin/bugfix/test"]
        
        let grade = sut.run(projectData: emptyProjectData())
        
        XCTAssertEqual(grade.violationCount, 3)
    }
    
}

class FakeGitCheckMergedBranchSwiftRule: GitCheckMergedBranchSwiftRule {
    
    var mergedBranches: [String]?
    
    override func getMergedBranches() throws -> [String]? {
        return mergedBranches
    }
    
}