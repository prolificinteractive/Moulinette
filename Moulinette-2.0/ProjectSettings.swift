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
    static var injectableDependencies = [""]
    
    /// Name of the project.
    let projectName: String
    
    /// Directory of the project.
    let projectDirectory: String

    init() {
        #if INTERNAL
            projectName = "HSN"
            projectDirectory = "/Users/jonsamudio/Prolific-Projects/HSN/HSN/"
            return
        #else
            
        let userDefaults = UserDefaults.standard.dictionaryRepresentation()
        guard let projectName = userDefaults["projectName"] as? String,
            let auditSubDirectory = userDefaults["auditSubDirectory"] as? String else {
            print("Error: projectName or auditSubDirectory not specified!")
            exit(1)
        }
        self.projectName = projectName
        projectDirectory = FileManager.default.currentDirectoryPath + auditSubDirectory
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
}
