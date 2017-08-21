//
//  Constants.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/30/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct Constants {

    static let fileExtensions = ["swift", "strings", "plist", "md", "pbxproj", "storyboard"]
    static let validNonSwiftFiles = ["Podfile", "Localizable.strings", "project.pbxproj"]
    static let defaultFolders = ["Features", "Model", "Utility", "Resources", "Supporting Files"]

    struct FileNameConstants {
        static let swiftSuffix = "swift"
        static let stringSuffix = "strings"
        static let appDelegate = "AppDelegate.swift"
        static let localizable = "Localizable.strings"
        static let plistSuffix = "plist"
        static let readme = "README.md"
        static let xcodeProject = "project.pbxproj"
    }

    struct Regex {
        static let comment = "(/\\*([^*]|[\\r\\n]|(\\*+([^*/]|[\\r\\n])))*\\*+/)|(//.*)"
    }

    struct URL {
        static let pivotal = "https://www.pivotaltracker.com/"
    }
}
