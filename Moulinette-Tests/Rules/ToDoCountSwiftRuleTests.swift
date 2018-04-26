//
//  ToDoCountSwiftRuleTests.swift
//  Moulinette-2.0
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
        sut = ToDoCountSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_ElevenTodoOneFile() {
        let data = projectData(components: ["Sample.swift": todoLines(count: ToDoCountSwiftRule.maxTodoCount + 10)])
        sut = ToDoCountSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, Int.max)
    }
    
    func testRun_OneTodoElevenFiles() {
        let data = projectData(components: todoFiles(count: 20))
        sut = ToDoCountSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, Int.max)
    }
    
// MARK: - Default Tests
    
    func testRun_EmptyProject() {
        sut = ToDoCountSwiftRule(projectData: emptyProjectData())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_EmptySingleFile() {
        sut = ToDoCountSwiftRule(projectData: emptyProjectFile())
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
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
