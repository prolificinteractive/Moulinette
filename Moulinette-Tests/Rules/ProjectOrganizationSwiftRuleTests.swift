//
//  ProjectOrganizationSwiftRuleTests.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 8/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

class ProjectOrganizationSwiftRuleTests: XCTestCase {

    var sut: ProjectOrganizationSwiftRule!
    
    func testRun_AllDefaultFoldersIncluded() {
        sut = ProjectOrganizationSwiftRule(projectData: projectData(folders: ProjectOrganizationSwiftRule.defaultFolders))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 0)
    }
    
    func testRun_FeaturesFolderMissing() {
        sut = ProjectOrganizationSwiftRule(projectData: projectData(folders: folders(removedFolder: "Features")))
        
        let grade = sut.run()

        XCTAssertEqual(grade.violations, 1)
    }
    
    func testRun_ModelMissing() {
        sut = ProjectOrganizationSwiftRule(projectData: projectData(folders: folders(removedFolder: "Model")))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 1)
    }
    
    func testRun_UtilityMissing() {
        sut = ProjectOrganizationSwiftRule(projectData: projectData(folders: folders(removedFolder: "Utility")))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 1)
    }
    
    func testRun_ResourcesMissing() {
        sut = ProjectOrganizationSwiftRule(projectData: projectData(folders: folders(removedFolder: "Resources")))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 1)
    }
    
    func testRun_SupportingFilesMissing() {
        sut = ProjectOrganizationSwiftRule(projectData: projectData(folders: folders(removedFolder: "Supporting Files")))
        
        let grade = sut.run()
        
        XCTAssertEqual(grade.violations, 1)
    }
}

private extension ProjectOrganizationSwiftRuleTests {
    
    func projectData(folders: [String]) -> ProjectData {
        var components = ApplicationComponents(with: ["Empty Project": []])
        components.filePaths = folders
        return ProjectData(path: "", applicationComponents: components)
    }
    
    func folders(removedFolder: String) -> [String] {
        return ProjectOrganizationSwiftRule.defaultFolders.filter { !($0 == removedFolder)}
    }
}
