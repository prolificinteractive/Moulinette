//
//  ATSExceptionSwiftRuleTests.swift
//  Moulinette
//
//  Created by Lee Pollard  on 8/9/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

@testable import Moulinette
class ATSExceptionSwiftRuleTests: XCTestCase {
    
    var sut: ATSExceptionSwiftRule!

    var exceptionPlistData = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>NSAppTransportSecurity</key>
        <dict>
            <key>NSExceptionDomains</key>
            <dict>
                <key>prolificinteractive.com</key>
                <string></string>
            </dict>
        </dict>
    </dict>
    </plist>
    """

    var noExceptionPlistData = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>NSAppTransportSecurity</key>
        <dict>
            <key>NSExceptionDomains</key>
            <dict/>
        </dict>
    </dict>
    </plist>
    """
    
    func testATSExceptionSwiftRuleTests_ExceptionFound() {
        sut = ATSExceptionSwiftRule()
        let data = projectData(components: ["ExceptionDomains.plist": exceptionPlistData.components(separatedBy: "\n")])

        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testATSExceptionSwiftRuleTests_NoExceptionFound() {
        sut = ATSExceptionSwiftRule()
        let data = projectData(components: ["NoExceptionDomains.plist": noExceptionPlistData.components(separatedBy: "\n")])

        let grade = sut.run(projectData: data)
        
        XCTAssertEqual(grade.violationCount, 0)
    }
}
