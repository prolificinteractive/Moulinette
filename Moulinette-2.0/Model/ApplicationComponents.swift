//
//  ApplicationComponents.swift
//  Moulinette-2.0
//
//  Created by Morgan Collino on 7/18/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Application components.
struct ApplicationComponents {
    
    // [Filename: [Lines]]
    var components: [String : [String]] = [:]

    /// Swift files.
    var swiftFiles: [(String, [String])] {
        return files(for: Constants.FileNameConstants.swiftSuffix)
    }
    
    // String files.
    var stringFiles: [(String, [String])] {
        return files(for: Constants.FileNameConstants.stringSuffix)
    }
    
    /// Init function with file names.
    ///
    /// - Parameter fileNames: File names.
    init(with fileNames: [String]) {
        for file in fileNames {
            let fileToParse = settings.projectDirectory + file
            
            do {
                let content = try String(contentsOfFile: fileToParse, encoding: String.Encoding.utf8)
                let fileComponents = content.components(separatedBy: "\n")
                guard let strippedFileName = file.fileName() else {
                    throw ParseError.error("Failed to parse Swift file name")
                }
                components[strippedFileName] = fileComponents
            } catch {
                print("Error caught with message: \(error.localizedDescription)")
            }
        }
    }
    
    /// Init function for components. Used for testing.
    ///
    /// - Parameter components: components of the app.
    init(with components: [String : [String]]) {
        self.components = components
    }
    
    /// Filtering function to get component for given file name.
    ///
    /// - Parameter name: File name,
    /// - Returns: Content of file with the filename given.
    func file(by name: String) -> [String]? {
        return components[name]
    }
 
    /// Filtering function to get components for given path extension (swift, strings).
    ///
    /// - Parameter pathExtension: Path extension.
    /// - Returns: Array of potential components with the path extension given.
    func files(for pathExtension: String) -> [(String, [String])] {
        let files = components.filter { (fileName, content) -> Bool in
            let nsstring = fileName as NSString
            return nsstring.pathExtension == pathExtension
        }
        
        return files
    }
    
}
