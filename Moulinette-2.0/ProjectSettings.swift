//
//  ProjectSettings.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct ProjectSettings {
    
    static let excludedFiles = ["Constants.swift"]
    static let excludedDirectories = ["Pods", "Scripts", "Tools", "fastlane"]
    static let excludedDirectoryRegex = ["^[#].*", "]*Test]*", "]*.framework", "]*.xcodeproj", "]*.xcworkspace", "^[\\.].*"]
    
    static var injectableDependencies = [""]
    
    /// Name of the project.
    let projectName: String
    
    /// Directory of the project.
    let projectDirectory: String
    
    /// Project identifier.
    let projectIdentifier: String

    /// Silent mode. (No output call to API)
    let silentMode: Bool
    
    init() {
        #if INTERNAL
            projectName = ProjectSettings.getEnvironmentVar("PROJECT_NAME")!
            projectDirectory = ProjectSettings.getEnvironmentVar("PROJECT_DIR")!
            projectIdentifier = ProjectSettings.getEnvironmentVar("PROJECT_IDENTIFIER")!
            silentMode = ProjectSettings.getEnvironmentVar("SILENT_MODE") == "TRUE"
        #else
            let userDefaults = UserDefaults.standard.dictionaryRepresentation()
            guard let projectName = userDefaults["projectName"] as? String,
                let bundleIdentifier = userDefaults["bundleIdentifier"] as? String,
                let silentMode = userDefaults["silent"] as? Bool else {
                    print("Error: projectName or bundle identifier not specified!")
                    exit(1)
            }
            self.projectName = projectName
            projectDirectory = FileManager.default.currentDirectoryPath
            self.projectIdentifier = bundleIdentifier
            self.silentMode = silentMode
        #endif
    }
    
    static func isExcluded(file: String) -> Bool {
        for excludedFile in excludedFiles {
            if file.contains(excludedFile) {
                return true
            }
        }
        return false
    }
    
    static func getEnvironmentVar(_ name: String) -> String? {
        guard let rawValue = getenv(name) else { return nil }
        return String(utf8String: rawValue)
    }
    
}
