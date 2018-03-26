//
//  SinglePublicInternalSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class SinglePublicInternalSwiftRuleTests: XCTestCase {

    var sut: SinglePublicInternalSwiftRule!
    
    func testRun_SingleTypeClass() {
        sut = SinglePublicInternalSwiftRule(projectData: projectData(line: "class SampleClass {}"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_SingleTypeEnum() {
        sut = SinglePublicInternalSwiftRule(projectData: projectData(line: "enum {}"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_SingleTypeProtocol() {
        sut = SinglePublicInternalSwiftRule(projectData: projectData(line: "protocol SampleProtocol {}"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_SingleTypeStruct() {
        sut = SinglePublicInternalSwiftRule(projectData: projectData(line: "struct SampleStruct {}"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_ConstantsFile() {
        sut = SinglePublicInternalSwiftRule(projectData: projectData(fileName: "Constants", line: "struct Constants"))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = SinglePublicInternalSwiftRule(projectData: emptyProjectData())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_EmptySingleFile() {
        sut = SinglePublicInternalSwiftRule(projectData: emptyProjectFile())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
// MARK: - Class Type
    
    func testRun_ClassAndClassFile() {
        let data = projectData(components: ["Sample.swift" : ["class Sample1 {}", "final class Sample2 {}"]])
        sut = SinglePublicInternalSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_ClassAndEnumFile() {
        let data = projectData(components: ["Sample.swift" : ["class Sample1 {}", "enum Test {}"]])
        sut = SinglePublicInternalSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_ClassAndProtocolFile() {
        let data = projectData(components: ["Sample.swift" : ["class Sample1 {}", "protocol Test {}"]])
        sut = SinglePublicInternalSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_ClassAndStructFile() {
        let data = projectData(components: ["Sample.swift" : ["class Sample1 {}", "struct Test {}"]])
        sut = SinglePublicInternalSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
// MARK: - Enum Type
    
    func testRun_EnumAndEnum() {
        let data = projectData(components: ["Sample.swift" : ["enum Sample1 {}", "enum Test {}"]])
        sut = SinglePublicInternalSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_EnumAndProtocol() {
        let data = projectData(components: ["Sample.swift" : ["protocol Sample1 {}", "enum Test {}"]])
        sut = SinglePublicInternalSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_EnumAndStruct() {
        let data = projectData(components: ["Sample.swift" : ["struct Sample1 {}", "enum Test {}"]])
        sut = SinglePublicInternalSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
// MARK: - Protocol Type
    
    func testRun_ProtocolAndProtocol() {
        let data = projectData(components: ["Sample.swift" : ["protocol Sample1 {}", "protocol Test {}"]])
        sut = SinglePublicInternalSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_ProtocolAndStruct() {
        let data = projectData(components: ["Sample.swift" : ["protocol Sample1 {}", "struct Test {}"]])
        sut = SinglePublicInternalSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
// MARK: - Struct Type
    
    func testRun_StructAndStruct() {
        let data = projectData(components: ["Sample.swift" : ["struct Sample1 {}", "struct Test {}"]])
        sut = SinglePublicInternalSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violationCount, 1)
    }
}
