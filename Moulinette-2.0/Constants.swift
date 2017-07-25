//
//  Constants.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/30/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct Constants {

    static let fileExtensions = ["swift", "strings", "plist", "md"]

    struct FileNameConstants {
        static let swiftSuffix = "swift"
        static let stringSuffix = "strings"
        static let appDelegate = "AppDelegate.swift"
        static let localizable = "Localizable.strings"
        static let readme = "README.md"
    }
    
    struct SwiftComponents {
        
    }

    struct Regex {
        static let comment = "(/\\*([^*]|[\\r\\n]|(\\*+([^*/]|[\\r\\n])))*\\*+/)|(//.*)"
    }

    struct URL {
        static let pivotal = "https://www.pivotaltracker.com/"
    }

}
