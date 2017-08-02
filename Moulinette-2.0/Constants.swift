//
//  Constants.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/30/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct Constants {

    static let fileExtensions = ["swift", "strings", "plist"]

    struct FileNameConstants {
        static let swiftSuffix = "swift"
        static let stringSuffix = "strings"
        static let appDelegate = "AppDelegate.swift"
        static let localizable = "Localizable.strings"
        static let swiftDotSuffix = ".swift"
    }
    
    struct SwiftComponents {
        static let varString = "var"
        static let overrideString = "override"
        static let privateString = "private"
        static let fileprivateString = "fileprivate"
        static let ibOutletString = "@IBOutlet"
        static let colonString = ":"
        static let classString = "class"
        static let internalString = "internal"
        static let openCurlyBracketString = "{"
        static let commaString = ","
        static let protocolString = "protocol"
        static let letString = "let"
        static let getString = "get"
        static let equalString = "="
    }

    struct Regex {
        static let comment = "(/\\*([^*]|[\\r\\n]|(\\*+([^*/]|[\\r\\n])))*\\*+/)|(//.*)"
    }

    struct URL {
        static let pivotal = "https://www.pivotaltracker.com/"
    }

}
