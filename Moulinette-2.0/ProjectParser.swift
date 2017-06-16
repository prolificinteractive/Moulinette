//
//  ProjectParser.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/30/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

class ProjectParser {
    
    func applicationComponents() -> ApplicationComponents {
        let swiftFileNames = retrieveSwiftFileNames()
        var applicationFileComponents = ApplicationComponents()
        
        for swiftFile in swiftFileNames {
            let fileToParse = settings.projectDirectory + swiftFile
            
            do {
                let content = try String(contentsOfFile: fileToParse, encoding: String.Encoding.utf8)
                let fileComponents = content.components(separatedBy: "\n")
                applicationFileComponents[swiftFile] = fileComponents
            } catch _ as NSError {
                print("Error")
            }
        }
        
        return applicationFileComponents
    }
    
    private func retrieveSwiftFileNames() -> [String] {
        let fileEnumerator = FileManager.default.enumerator(atPath: settings.projectDirectory)
        var swiftFiles = [String]()
                
        while let file = fileEnumerator?.nextObject() {
            guard let file = file as? String, file.contains(Constants.FileNameConstants.swiftSuffix) else {
                continue
            }
            
            if !ProjectSettings.isExcluded(file: file) {
                swiftFiles.append(file)
            }
        }
        
        return swiftFiles
    }
}
