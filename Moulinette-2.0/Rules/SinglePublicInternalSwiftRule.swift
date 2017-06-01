//
//  SinglePublicInternalSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class SinglePublicInternalSwiftRule: SwiftRule {
    
    let name: String = "One public/internal type per file (class, enum, protocol, struct)"
    
    private var projectData: ProjectData
    private var failedString = ""
    
    private var type: FileType?
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> GradeType {
        for (fileName, fileComponents) in projectData.applicationComponents {
            fileComponents.forEach {
                if let fileType = FileType.type(fileLine: $0) {
                    if type != nil {
                        failedString += formattedFailedString(fileName: fileName, fileLine: $0)
                    }
                    type = fileType
                }
            }
            type = nil
        }
        return (failedString == "") ? .pass : .fail(failedString)
    }
}
