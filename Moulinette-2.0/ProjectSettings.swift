//
//  ProjectSettings.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct ProjectSettings {
    
    static let baseDir = "/Users/jonsamudio/Prolific-Projects/HSN/HSN/"
    
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
}
