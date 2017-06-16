//
//  ProjectSettings.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct ProjectSettings {
    
    var baseDir: String
    
    var projectName: String
    
    static let excludedFiles = ["Constants.swift"]
    
    static func isExcluded(file: String) -> Bool {
        for excludedFile in excludedFiles {
            if file.contains(excludedFile) {
                return true
            }
        }
        return false
    }
    
    static var injectableDependencies = [""]
    
    init() {
        let userDefaults = UserDefaults.standard.dictionaryRepresentation()
        guard let baseDir = userDefaults["baseDirectory"] as? String,
            let projectName = userDefaults["projectName"] as? String else {
                print("Project Settings Not Specified")
                exit(1)
        }
        self.baseDir = baseDir
        self.projectName = projectName
    }
}
