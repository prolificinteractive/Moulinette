//
//  CompletionWeakSwiftRuleTests.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 7/19/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class CompletionWeakSwiftRuleTests: XCTestCase {

    var sut: CompletionWeakSwiftRule!
    
    func testNonCompletionBlock_Self() {
        sut = CompletionWeakSwiftRule()
        
        let grade = sut.run(projectData: nonCompletionSelfSample())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testNonCompletionBlock_NoSelf() {
        sut = CompletionWeakSwiftRule()
        
        let grade = sut.run(projectData: nonCompletionNoSelfSample())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testCompletionBlock_NonWeakSelf() {
        sut = CompletionWeakSwiftRule()
        
        let grade = sut.run(projectData: completionNonWeakSelfSample())
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testCompletionBlock_WeakSelf() {
        sut = CompletionWeakSwiftRule()
        
        let grade = sut.run(projectData: completionWeakSelfSample())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testCompletionBlock_NoSelf() {
        sut = CompletionWeakSwiftRule()
        
        let grade = sut.run(projectData: completionNoSelfSample())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testCompletionBlock_Struct() {
        sut = CompletionWeakSwiftRule()
        
        let grade = sut.run(projectData: completionNoSelfSample())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
}

private extension CompletionWeakSwiftRuleTests {
    
    func nonCompletionSelfSample() -> ProjectData {
        let fileComponents = ["func test() { ",
                              "self.something = something",
                              "}"]
        
        return ProjectData(path: "", applicationComponents: ApplicationComponents(with: ["SampleFile" : fileComponents]))
    }
    
    func nonCompletionNoSelfSample() -> ProjectData {
        let fileComponents = ["func test() { ",
                              "somthing.somethingCool()",
                              "}"]
        
        return ProjectData(path: "", applicationComponents: ApplicationComponents(with: ["SampleFile" : fileComponents]))
    }
    
    func completionNonWeakSelfSample() -> ProjectData {
        let fileComponents = ["networkProvider.applePayLoader.applePayBag(completion: { (_) in",
                              "self.something = something",
                              "}?"]
        
        return ProjectData(path: "", applicationComponents: ApplicationComponents(with: ["SampleFile" : fileComponents]))
    }
    
    func completionWeakSelfSample() -> ProjectData {
        let fileComponents = ["networkProvider.applePayLoader.applePayBag(completion: { [weak self] (_) in",
                              "self?.something = something",
                              "}?"]
        
        return ProjectData(path: "", applicationComponents: ApplicationComponents(with: ["SampleFile" : fileComponents]))
    }
    
    func completionNoSelfSample() -> ProjectData {
        let fileComponents = ["networkProvider.applePayLoader.applePayBag(completion: { (_) in",
                              "something.somethingCool()",
                              "}?"]
        
        return ProjectData(path: "", applicationComponents: ApplicationComponents(with: ["SampleFile" : fileComponents]))
    }
    
    func structCompletionNonWeakSelfSample() -> ProjectData {
        let fileComponents = ["struct {",
                              "networkProvider.applePayLoader.applePayBag(completion: { (_) in",
                              "self.something = something",
                              "}?",
                              "}"]
        
        return ProjectData(path: "", applicationComponents: ApplicationComponents(with: ["SampleFile" : fileComponents]))
    }
}
