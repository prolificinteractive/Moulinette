//
//  ForceUnwrapSwiftRuleTests.swift
//  Moulinette
//
//  Created by Dominic Ancrum on 5/16/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import XCTest

class ForceUnwrapSwiftRuleTests: XCTestCase {

    var sut: ForceUnwrapSwiftRule!

    override func setUp() {
        super.setUp()

        sut = ForceUnwrapSwiftRule()
    }

    func testRun_ForceUnwrapProperty() {
        let forceUnwrapPropertyData = projectData(fileName: "Sample.swift", line: "let property: String!")

        let grade = sut.run(projectData: forceUnwrapPropertyData)

        XCTAssertEqual(grade.violationCount, 1)
    }

    func testRun_ForceUnwrapIBOutletProperty() {
        let forceUnwrapIBOutletData = projectData(fileName: "Sample.swift", line: "@IBOutlet let label: UILabel!")

        let grade = sut.run(projectData: forceUnwrapIBOutletData)

        XCTAssertEqual(grade.violationCount, 0)
    }

    func testRun_ForceTypeDowncasting() {
        let forceCastData = projectData(fileName: "Sample.swift", line: "let property = property as! DerivedType")

        let grade = sut.run(projectData: forceCastData)

        XCTAssertEqual(grade.violationCount, 1)
    }

}
