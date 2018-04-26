//
//  FileFilteringTests.swift
//  Moulinette-Tests
//
//  Created by Morgan Collino on 7/19/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

/// File filtering tests.
class FileFilteringTests: XCTestCase {

    var sut: ProjectParser!

    override func setUp() {
        super.setUp()
    }

    func testRun_Filtering() {
        sut = ProjectParser()
        let components = fakeFilenames()
        do {
            let filteredComponents = try components.filter(sut.filterClosure)
            print(filteredComponents)
            XCTAssert(filteredComponents == result())
        } catch {
            XCTAssert(false, "Filter component closure failed.")
        }
    }

}

// MARK: - Fake helper methods.
extension FileFilteringTests {
    
    func fakeFilenames() -> [String] {
        return [
            "AppDelegate.swift",
            ".git",
            "Info.plist",
            "Hello.strings",
            "Toto.xcodeproj",
            "TotoTest/Plop",
            "Scripts/test",
            "fastlane/toot",
            "Tools/Poool",
            "Leto.xcworkspace",
            "#FILE#",
            "Toto.framework",
            "Pods/FTW",
            "Dope.swift"
            ]
    }
    
    func result() -> [String] {
        return ["AppDelegate.swift", "Info.plist", "Hello.strings", "Dope.swift"]
    }
    
}
