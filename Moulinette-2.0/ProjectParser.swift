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

class ProjectParser {
    
    // Private file filter closure.
    private var filterClosure: ((Any) throws -> Bool) = { (file) -> Bool in
        guard let fileName = file as? NSString else {
            return false
        }
        
        var isExcluded = false
        
        // Check if the root directory is excluded.
        for excludedDirectory in ProjectSettings.excludedDirectories {
            isExcluded = isExcluded || fileName.pathComponents.first == excludedDirectory
        }
        
        // No need to do the pattern check if the file is already excluded.
        if isExcluded == false {
            for excludedDirectoryPattern in ProjectSettings.excludedDirectoryRegex {
                let regex = try NSRegularExpression(pattern: excludedDirectoryPattern, options: .caseInsensitive)
                let matches = regex.matches(in: fileName as String, options: [], range: NSRange(location: 0, length: fileName.length))
                
                isExcluded = isExcluded || matches.count > 0
            }
        }
        
        return !isExcluded
    }
    
    func applicationComponents() -> ApplicationComponents {
        let swiftFilenames = retrieveSwiftFilenames()
        var applicationFileComponents = ApplicationComponents()

        for swiftFile in swiftFilenames {
            let fileToParse = settings.projectDirectory + swiftFile

            do {
                let content = try String(contentsOfFile: fileToParse, encoding: String.Encoding.utf8)
                let fileComponents = content.components(separatedBy: "\n")
                guard let strippedFileName = swiftFile.fileName() else {
                    throw ParseError.error("Failed to parse Swift file name")
                }
                applicationFileComponents[strippedFileName] = fileComponents
            } catch {
                print("Error caught with message: \(error.localizedDescription)")
            }
        }

        return applicationFileComponents
    }

    private func retrieveSwiftFilenames() -> [String] {
        let fileEnumerator = FileManager.default.enumerator(atPath: settings.projectDirectory)
        var files: [String] = []
        
        do {
            guard let filteredFileEnumerator = try fileEnumerator?.filter(filterClosure) as? [String] else {
                return files
            }
            
            for file in filteredFileEnumerator {
                guard file.hasValidFileExtension() else {
                    continue
                }
                
                if !ProjectSettings.isExcluded(file: file) {
                    files.append(file)
                }
                
            }
        } catch {
            print("Error caught with message: \(error.localizedDescription)")
        }
        
        return files
    }
}
