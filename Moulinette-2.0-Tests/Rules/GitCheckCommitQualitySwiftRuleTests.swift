//
//  GitCheckCommitQualitySwiftRuleTests.swift
//  Moulinette-2.0-Tests
//
//  Created by Morgan Collino on 12/19/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class GitCheckCommitQualitySwiftRuleTests: XCTestCase {
    
    var sut: FakeGitCheckCommitQualitySwiftRule!
    
    func test_NormalCommits() {
        sut = FakeGitCheckCommitQualitySwiftRule()
      
        let commits = "commit 01a1d71fd75541defd7b0335214c66379ad54bbb\nAuthor: Harlan Kellaway <harlan@prolificinteractive.com>\nDate:   Mon Dec 18 15:11:28 2017 -0500\n\n    Refactored PDP feature out of SDK\n\ncommit ad5cb23afe32c50cfa2694c1d0d8939088a965b4\nAuthor: Dominic Ancrum <dominic@prolificinteractive.com>\nDate:   Mon Dec 18 12:57:12 2017 -0500\n\n    Present filter options for selected filter\n\ncommit 861e2f12f1a40071ff180102f319bc1252569477\nAuthor: Dominic Ancrum <dominic@prolificinteractive.com>\nDate:   Mon Dec 18 12:16:04 2017 -0500\n\n    Sort/Filter - Fix bug with empty results after applying sort\n\n"
        
        sut.fakeCommits = commits
        let grade = sut.run(projectData: emptyProjectData())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func test_BadCommits() {
        sut = FakeGitCheckCommitQualitySwiftRule()
        
        let commits = "commit 01a1d71fd75541defd7b0335214c66379ad54bbb\nAuthor: Harlan Kellaway <harlan@prolificinteractive.com>\nDate:   Mon Dec 18 15:11:28 2017 -0500\n\n    Refactored PDP feature out of SDK\n\ncommit 01a1d71fd75541defd7b0335214c66379ad54bbb\nAuthor: Harlan Kellaway <harlan@prolificinteractive.com>\nDate:   Mon Dec 18 15:11:28 2017 -0500\n\n    Test\n\ncommit 01a1d71fd75541defd7b0335214c66379ad54bbb\nAuthor: Harlan Kellaway <harlan@prolificinteractive.com>\nDate:   Mon Dec 18 15:11:28 2017 -0500\n\n     \n\n"
        
        sut.fakeCommits = commits
        
        let grade = sut.run(projectData: emptyProjectData())
        
        XCTAssertEqual(grade.violationCount, 2)
    }
    
}

class FakeGitCheckCommitQualitySwiftRule: GitCheckCommitQualitySwiftRule {
    
    var fakeCommits: String?
    
    override func getCommits() throws -> [Commit] {
        return parseCommits(from: fakeCommits!)
    }
    
}

