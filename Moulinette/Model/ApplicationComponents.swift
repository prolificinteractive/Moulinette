//
//  ApplicationComponents.swift
//  Moulinette
//
//  Created by Morgan Collino on 7/18/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// File components array type.
typealias ProjectComponents = [String : [String]]
typealias FileCollection = [(String, [String])]

/// Application components.
struct ApplicationComponents {
    
    // [Filename: [Lines]]
    var components: ProjectComponents = [:]

    /// File paths to all of the files in the application.
    var filePaths: [String] = []
    
    /// Project assets with full file path used to determine with icon is associated to which contents file.
    var assets: ProjectComponents = [:]
    
    /// Swift files.
    var swiftFiles: FileCollection {
        return files(for: Constants.FileNameConstants.swiftSuffix)
    }

    var objectiveCFiles: FileCollection {
        return files(for: Constants.FileNameConstants.objectiveCSuffix)
    }
    
    // String files.
    var stringFiles: FileCollection {
        guard let stringFiles = configFile?.localizationFiles else {
            return files(for: Constants.FileNameConstants.stringSuffix)
        }
        return stringFiles.compactMap { file(filterBy: $0).first }
    }
    
    // README file components.
    var readmeComponents: [String]? {
        return file(by: Constants.FileNameConstants.readme)
    }

    // Podfile components.
    var podfileComponents: [String]? {
        return file(by: Constants.FileNameConstants.podfile)
    }

    private let configFile: ConfigurationFile?
    
    /// Init function with file names.
    ///
    /// - Parameter fileNames: File names.
    init(with fileNames: [String], configFile: ConfigurationFile? = nil) {
        self.configFile = configFile

        for file in fileNames {
            let fileToParse = settings.projectDirectory + file
            filePaths.append(file)
            
            do {
                let content = try String(contentsOfFile: fileToParse, encoding: String.Encoding.utf8)
                let fileComponents = content.components(separatedBy: "\n")

                components[file] = formatFileComponents(components: fileComponents)
                setupProjectAssets(filePath: file, fileComponents: fileComponents)
            } catch {
                print("Error caught with message: \(error.localizedDescription)")
            }
        }
    }
    
    /// Init with custom components.
    ///
    /// - Parameter components: Components.
    init(with components: ProjectComponents, configFile: ConfigurationFile? = nil) {
        self.components = components
        self.configFile = configFile
    }
    
    /// Filtering function to get component for given file name.
    ///
    /// - Parameter name: File name,
    /// - Returns: Content of file with the filename given.
    func file(by name: String) -> [String]? {
        return file(filterBy: name).first?.1
    }
    
    /// Filtering function to get component for given file name.
    ///
    /// - Parameter name: File name,
    /// - Returns: List of file containing the file name given.
    func file(filterBy name: String) -> FileCollection {
        let files = components.filter { (fileName, content) -> Bool in
            return fileName.contains(name)
            }.map { ($0.key, $0.value)}
        
        return files
    }
    
    /// Filtering function to get components for given path extension (swift, strings).
    ///
    /// - Parameter pathExtension: Path extension.
    /// - Returns: Array of potential components with the path extension given.
    func files(for pathExtension: String) -> FileCollection {
        let files = components.filter { (fileName, content) -> Bool in
            let nsstring = fileName as NSString
            return nsstring.pathExtension == pathExtension
        }.map { ($0.key, $0.value) }
        
        return files
    }
    
    /// Merge contents of multiples files.
    ///
    /// - Parameter files: Given files.
    /// - Returns: Content of those files concatenated.
    func mergeContents(files: [(String, [String])]) -> String {
        return files.compactMap { (fileName, fileContents) -> String? in
            return fileContents.joined()
            }.joined()
    }

    func formatFileComponents(components: [String]) -> [String] {
        return components.map { $0.components(separatedBy: "\r") }.reduce([], +)
    }
    
}

private extension ApplicationComponents {
    
    mutating func setupProjectAssets(filePath: String, fileComponents: [String]) {
        if filePath.contains(Constants.FileNameConstants.AssetContents) {
            assets[filePath] = fileComponents
        }
    }
}
