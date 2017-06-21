//
//  StringExtensionTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

class StringExtensionTests: XCTestCase {

    var sut: String!
    
// MARK: - isProjectClass
    
    func testIsProjectClass_Class() {
        sut = "class Test: Subclass {"
        
        let isClass = sut.isProjectClass()
        
        XCTAssertTrue(isClass)
    }
    
    func testIsProjectClass_Comment() {
        sut = "//class Test: Subclass {"
        
        let isClass = sut.isProjectClass()
        
        XCTAssertFalse(isClass)
    }
    
    func testIsProjectClass_Protocol() {
        sut = "protocol Test: class {"
        
        let isClass = sut.isProjectClass()
        
        XCTAssertFalse(isClass)
    }
    
    func testIsProjectClass_Func() {
        sut = "class func Test {"
        
        let isClass = sut.isProjectClass()
        
        XCTAssertFalse(isClass)
    }
    
    func testIsProjectClass_Random() {
        sut = "HelloThisIsATest"
        
        let isClass = sut.isProjectClass()
        
        XCTAssertFalse(isClass)
    }

// MARK: - className

    func testClassName_Class() {
        sut = "class Hello {"
        
        let className = sut.className()
        
        XCTAssertEqual(className, "Hello")
    }
    
    func testClassName_ClassSubClass() {
        sut = "class Hello: Subclass {"
        
        let className = sut.className()
        
        XCTAssertEqual(className, "Hello")
    }
    
    func testClassName_InvalidClass() {
        sut = "class Hello "
        
        let className = sut.className()
        
        XCTAssertNil(className)
    }
    
// MARK: - subClassName
    
    func testSubClassName_Class() {
        sut = "class Hello {"
        
        let className = sut.subClassName()
        
        XCTAssertNil(className)
    }
    
    func testSubClassName_ClassSubClass() {
        sut = "class Hello: Subclass {"
        
        let className = sut.subClassName()
        
        XCTAssertEqual(className, "Subclass")
    }
    
    func testSubClassName_MultipleSubClass() {
        sut = "class Hello: Subclass, AnotherOne "
        
        let className = sut.subClassName()
        
        XCTAssertEqual(className, "Subclass")
    }
}
