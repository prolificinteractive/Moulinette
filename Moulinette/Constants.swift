//
//  Constants.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 5/30/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct Constants {

    static let fileExtensions = ["swift", "strings", "plist", "md", "pbxproj", "storyboard", "json", "gitignore", "m"]
    static let validNonSwiftFiles = ["AppDelegate", "Podfile", "project.pbxproj", ".gitignore"]

    static var markFormat = "// MARK: - "
    
    struct FileNameConstants {
        static let swiftSuffix = "swift"
        static let objectiveCSuffix = "m"
        static let stringSuffix = "strings"
        static let appDelegate = "AppDelegate.swift"
        static let localizable = "Localizable.strings"
        static let plistSuffix = "plist"
        static let readme = "README.md"
        static let xcodeProject = "project.pbxproj"
        static let AssetContents = "Contents.json"
        static let moulinetteName = "Moulinette"
        static let gitIgnore = ".gitignore"
        static let podfile = "Podfile"
    }

    struct Regex {
        static let comment = "(/\\*([^*]|[\\r\\n]|(\\*+([^*/]|[\\r\\n])))*\\*+/)|(//.*)"
    }

    struct URL {
        static let pivotal = "https://www.pivotaltracker.com/"
    }
}
