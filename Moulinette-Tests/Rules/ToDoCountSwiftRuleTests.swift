//
//  ToDoCountSwiftRuleTests.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 8/24/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette
class ToDoCountSwiftRuleTests: XCTestCase {

    var sut: ToDoCountSwiftRule!
    
    func testRun_OneTodoOneFile() {
        let data = projectData(fileName: "Sample.swift", line: "// TODO: Do something cool")
        sut = ToDoCountSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_ElevenTodoOneFile() {
        let data = projectData(components: ["Sample.swift": todoLines(count: ToDoCountSwiftRule.maxTodoCount + 10)])
        sut = ToDoCountSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, Int.max)
    }
    
    func testRun_OneTodoElevenFiles() {
        let data = projectData(components: todoFiles(count: 20))
        sut = ToDoCountSwiftRule()
        
        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, Int.max)
    }
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = ToDoCountSwiftRule()
        
        let grade = sut.run(projectData: emptyProjectData())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_EmptySingleFile() {
        sut = ToDoCountSwiftRule()
        
        let grade = sut.run(projectData: emptyProjectFile())
        
        XCTAssertEqual(grade.violationCount, 0)
    }
}

private extension ToDoCountSwiftRuleTests {
    
    func todoLines(count: Int) -> [String] {
        var todos = [String]()
        for _ in 0..<count {
            todos.append("// TODO: Do something cool")
        }
        return todos
    }
    
    func todoFiles(count: Int) -> ProjectComponents {
        var components = ProjectComponents()
        for i in 0..<count {
           components["\(String(i)).swift"] = todoLines(count: 1)
        }
        return components
    }
}
