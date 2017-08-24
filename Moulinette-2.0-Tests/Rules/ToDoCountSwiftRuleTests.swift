//
//  ToDoCountSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/24/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette_2_0
class ToDoCountSwiftRuleTests: XCTestCase {

    var sut: ToDoCountSwiftRule!
    
    func testRun_OneTodoOneFile() {
        let data = projectData(fileName: "Sample", line: "// TODO: Do something cool")
        sut = ToDoCountSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_ElevenTodoOneFile() {
        let data = projectData(components: ["Sample": todoLines(count: 11)])
        sut = ToDoCountSwiftRule(projectData: data)
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 1)
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
}
