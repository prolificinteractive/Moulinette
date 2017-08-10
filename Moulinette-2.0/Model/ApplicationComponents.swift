//
//  ApplicationComponents.swift
//  Moulinette-2.0
//
//  Created by Morgan Collino on 7/18/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import SourceKittenFramework

/// Application components.
struct ApplicationComponents {
    
    // [Filename: [Lines]]
    var components: [String: [String]] = [:]

    /// Swift files.
    var swiftFiles: [String: [String]] {
        return files(for: Constants.FileNameConstants.swiftSuffix)
    }
    
    // String files.
    var stringFiles: [String: [String]] {
        return files(for: Constants.FileNameConstants.stringSuffix)
    }
    
    // README file components.
    var readmeComponents: [String]? {
        return file(by: Constants.FileNameConstants.readme)
    }
    
    /// Init function with file names.
    ///
    /// - Parameter fileNames: File names.
    init(with fileNames: [String]) {
        for fileName in fileNames {
            let fileToParse = settings.projectDirectory + fileName
            guard let file = File(path: fileToParse) else {
                continue
            }
            
            let content = file.contents
            let fileComponents = content.components(separatedBy: "\n")
            guard let strippedFileName = fileName.fileName() else {
                continue
            }
            components[strippedFileName] = fileComponents
        }
    }
    
    /// Init with custom components.
    ///
    /// - Parameter components: Components.
    init(with components: [String: [String]]) {
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
    func files(for pathExtension: String) -> [String: [String]] {
        let files = components.filter { (fileName, content) -> Bool in
            let nsstring = fileName as NSString
            return nsstring.pathExtension == pathExtension
        }
        
        return files
    }
    
}
