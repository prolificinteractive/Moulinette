//
//  ProjectOrganizationSwiftRuleTests.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 8/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest

class ProjectOrganizationSwiftRuleTests: XCTestCase {

    var sut: ProjectOrganizationSwiftRule!
    
    func testRun_AllDefaultFoldersIncluded() {
        sut = ProjectOrganizationSwiftRule()
        
        let grade = sut.run(projectData: projectData(folders: ProjectOrganizationSwiftRule.defaultFolders))
        
        XCTAssertEqual(grade.violationCount, 0)
    }
    
    func testRun_FeaturesFolderMissing() {
        sut = ProjectOrganizationSwiftRule()
        
        let grade = sut.run(projectData: projectData(folders: folders(removedFolder: "Features")))

        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_ModelMissing() {
        sut = ProjectOrganizationSwiftRule()
        
        let grade = sut.run(projectData: projectData(folders: folders(removedFolder: "Model")))
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_UtilityMissing() {
        sut = ProjectOrganizationSwiftRule()
        
        let grade = sut.run(projectData: projectData(folders: folders(removedFolder: "Utility")))
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_ResourcesMissing() {
        sut = ProjectOrganizationSwiftRule()
        
        let grade = sut.run(projectData: projectData(folders: folders(removedFolder: "Resources")))
        
        XCTAssertEqual(grade.violationCount, 1)
    }
    
    func testRun_SupportingFilesMissing() {
        sut = ProjectOrganizationSwiftRule()
        
        let grade = sut.run(projectData: projectData(folders: folders(removedFolder: "Supporting Files")))
        
        XCTAssertEqual(grade.violationCount, 1)
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
