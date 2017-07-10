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

    func applicationComponents() -> ApplicationComponents {
        let swiftFileNames = retrieveFileNames()
        var applicationFileComponents = ApplicationComponents()

        for swiftFile in swiftFileNames {
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

    private func retrieveFileNames() -> [String] {
        let fileEnumerator = FileManager.default.enumerator(atPath: settings.projectDirectory)
        var files = [String]()

        while let file = fileEnumerator?.nextObject() {
            guard let file = file as? String, file.hasValidFileExtension() else {
                continue
            }

            if !ProjectSettings.isExcluded(file: file) {
                files.append(file)
            }
        }

        return files
    }
}
