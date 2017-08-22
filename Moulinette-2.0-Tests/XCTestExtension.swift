//
//  XCTestExtension.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

extension XCTest {
    
    /// Returns project data for the given parameters.
    ///
    /// - Parameter line: Single line of the project file.
    /// - Returns: Project data with a single file with a single line.
    func projectData(line: String) -> ProjectData {
        let applicationComponents = ApplicationComponents(with: ["Sample": [line]])
        return ProjectData(applicationComponents: applicationComponents)
    }
    
    /// Returns project data for the given parameters.
    ///
    /// - Parameter line: Single line of the project file.
    /// - Parameter fileName: Name of the file
    /// - Returns: Project data with a single file with a single line.
    func projectData(fileName: String, line: String) -> ProjectData {
        let applicationComponents = ApplicationComponents(with: [fileName: [line]])
        return ProjectData(applicationComponents: applicationComponents)
    }
    
    /// Empty project data.
    ///
    /// - Returns: Empty project data.
    func emptyProjectData() -> ProjectData {
        let components = ApplicationComponents(with: [:])
        return ProjectData(applicationComponents: components)
    }
}
