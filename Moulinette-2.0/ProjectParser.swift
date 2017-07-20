//
//  ProjectParser.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/30/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

enum ParseError: Error {
    case error(String)
}

/// Project parser.
final class ProjectParser {

    // MARK: - Private properties
    
    // Private file filter closure.
    let filterClosure: ((Any) throws -> Bool) = { (file) -> Bool in
        guard let fileName = file as? String else {
            return false
        }
        
        return try !ProjectParser.isExcluded(with: fileName)
    }
    
    // MARK: - Public functions
    
    func applicationComponents() -> ApplicationComponents {
        let fileNames = retrieveFilenames()
        return ApplicationComponents(with: fileNames)
    }

    // MARK: - Private functions
    
    private func retrieveFilenames() -> [String] {
        let fileEnumerator = FileManager.default.enumerator(atPath: settings.projectDirectory)
        do {
            guard let filteredFileEnumerator = try fileEnumerator?.filter(filterClosure) as? [String] else {
                print("Error filtering files.")
                return []
            }
 
            return filteredFileEnumerator
        } catch {
            print("Error caught with message: \(error.localizedDescription)")
        }
        
        return []
    }
    
    // MARK: - Private static functions
    
    private static func isExcluded(with file: String) throws -> Bool {
        let fileName = file as NSString
        
        return try checkExcludedDirectory(fileName: fileName)
            || checkExcludedDirectoryRegex(fileName: fileName)
            || !file.hasValidFileExtension()
            || ProjectSettings.isExcluded(file: file)
    }
    
    private static func checkExcludedDirectory(fileName: NSString) -> Bool {
        var isExcluded = false

        for excludedDirectory in ProjectSettings.excludedDirectories {
            isExcluded = isExcluded || fileName.pathComponents.first == excludedDirectory
        }
        
        return isExcluded
    }
    
    private static func checkExcludedDirectoryRegex(fileName: NSString) throws -> Bool {
        var isExcluded = false

        for excludedDirectoryPattern in ProjectSettings.excludedDirectoryRegex {
            let regex = try NSRegularExpression(pattern: excludedDirectoryPattern, options: .caseInsensitive)
            let matches = regex.matches(in: fileName as String, options: [], range: NSRange(location: 0, length: fileName.length))
            
            isExcluded = isExcluded || matches.count > 0
        }

        return isExcluded
    }
    
}
