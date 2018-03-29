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
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: projectData(line: "class SampleClass {}"))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_SingleTypeEnum() {
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: projectData(line: "enum {}"))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_SingleTypeProtocol() {
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: projectData(line: "protocol SampleProtocol {}"))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_SingleTypeStruct() {
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: projectData(line: "struct SampleStruct {}"))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_ConstantsFile() {
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: projectData(fileName: "Constants", line: "struct Constants"))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: emptyProjectData())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_EmptySingleFile() {
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: emptyProjectFile())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
// MARK: - Class Type
    
    func testRun_ClassAndClassFile() {
        let data = projectData(components: ["Sample.swift" : ["class Sample1 {}", "final class Sample2 {}"]])
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_ClassAndEnumFile() {
        let data = projectData(components: ["Sample.swift" : ["class Sample1 {}", "enum Test {}"]])
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_ClassAndProtocolFile() {
        let data = projectData(components: ["Sample.swift" : ["class Sample1 {}", "protocol Test {}"]])
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_ClassAndStructFile() {
        let data = projectData(components: ["Sample.swift" : ["class Sample1 {}", "struct Test {}"]])
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
// MARK: - Enum Type
    
    func testRun_EnumAndEnum() {
        let data = projectData(components: ["Sample.swift" : ["enum Sample1 {}", "enum Test {}"]])
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_EnumAndProtocol() {
        let data = projectData(components: ["Sample.swift" : ["protocol Sample1 {}", "enum Test {}"]])
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_EnumAndStruct() {
        let data = projectData(components: ["Sample.swift" : ["struct Sample1 {}", "enum Test {}"]])
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
// MARK: - Protocol Type
    
    func testRun_ProtocolAndProtocol() {
        let data = projectData(components: ["Sample.swift" : ["protocol Sample1 {}", "protocol Test {}"]])
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_ProtocolAndStruct() {
        let data = projectData(components: ["Sample.swift" : ["protocol Sample1 {}", "struct Test {}"]])
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
// MARK: - Struct Type
    
    func testRun_StructAndStruct() {
        let data = projectData(components: ["Sample.swift" : ["struct Sample1 {}", "struct Test {}"]])
        sut = SinglePublicInternalSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
}
