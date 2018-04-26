//
//  XCTestExtension.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

extension XCTest {
    
    /// Generates a project data with the given parameters.
    ///
    /// - Parameter components: Project components to add to the ApplicationComponents.
    /// - Returns: Initialized project data.
    func projectData(components: ProjectComponents) -> ProjectData {
        let components = ApplicationComponents(with: components)
        return ProjectData(path: "", applicationComponents: components)
    }
    
    /// Returns project data for the given parameters.
    ///
    /// - Parameter line: Single line of the project file.
    /// - Returns: Project data with a single file with a single line.
    func projectData(line: String) -> ProjectData {
        return projectData(components: ["Sample": [line]])
    }
    
    /// Returns project data for the given parameters.
    ///
    /// - Parameter line: Single line of the project file.
    /// - Parameter fileName: Name of the file
    /// - Returns: Project data with a single file with a single line.
    func projectData(fileName: String, line: String) -> ProjectData {
        return projectData(components: [fileName: [line]])
    }
    
    /// Empty project data.
    ///
    /// - Returns: Empty project data.
    func emptyProjectData() -> ProjectData {
        return projectData(components: [:])
    }
    
    /// Generates a project data object.
    ///
    /// - Returns: Project data with an empty single file.
    func emptyProjectFile() -> ProjectData {
        return projectData(components: ["Sample": []])
    }
}
