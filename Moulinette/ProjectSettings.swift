//
//  ProjectSettings.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct ProjectSettings {
    
    static let excludedFiles: [String] = ["Root.strings"]
    static let excludedDirectories = ["Pods", "Scripts", "Tools", "fastlane", "Build"]
    static let excludedDirectoryRegex = ["^[#].*", "]*Test]*", "]*.framework", "]*.xcworkspace"]
    
    static var injectableDependencies = [""]
    
    /// Name of the project.
    let projectName: String
    
    /// Directory of the project.
    let projectDirectory: String
    
    /// Project identifier.
    let projectIdentifier: String?

    /// Authentication token.
    let authToken: String?
    
    /// Silent mode. (No output call to API)
    let silentMode: Bool

    /// Debug mode.
    let debugMode: Bool

    /// Option for xcode build phase.
    let xcodePlugin: Bool
    
    init() {
        #if INTERNAL
            projectName = ProjectSettings.getEnvironmentVar("PROJECT_NAME")!
            projectDirectory = ProjectSettings.getEnvironmentVar("PROJECT_DIR")! + "/"
            projectIdentifier = ProjectSettings.getEnvironmentVar("PROJECT_IDENTIFIER")!
            silentMode = ProjectSettings.getEnvironmentVar("SILENT_MODE")?.uppercased() != "FALSE"
            debugMode = true
            xcodePlugin = true
            authToken = nil
        #else
            let userDefaults = UserDefaults.standard.dictionaryRepresentation()
            
            guard let projectName = userDefaults["projectName"] as? String,
                let projectDirectory = userDefaults["projectDirectory"] as? String else {
                    print("Error: Missing parameter.")
                    let errorString =
                    """
                    Eg: moulinette -projectName <projectName> -projectDirectory <projectDirectory>
                    [-silent <'true'/'false'> -verbose <'true'/'false'> -xcodePlugin <'true'/'false'>]
                    """
                    print(errorString)
                    exit(1)
            }
            
            self.projectName = projectName
            self.projectDirectory = projectDirectory + "/"

            projectIdentifier = userDefaults["projectIdentifier"] as? String
            authToken = userDefaults["authToken"] as? String
            
            if let silentMode = userDefaults["silent"] as? String,
                silentMode == "true" {
                self.silentMode = true
            } else {
                self.silentMode = false
            }
            
            if let debugMode = userDefaults["verbose"] as? String,
                debugMode == "true" {
                self.debugMode = true
            } else {
                self.debugMode = false
            }

            if let xcodePlugin = userDefaults["xcodePlugin"] as? String,
                xcodePlugin == "true" {
                self.xcodePlugin = true
            } else {
                self.xcodePlugin = false
            }
            
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
