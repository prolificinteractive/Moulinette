//
//  WeakIBOutletSwiftRule.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

final class WeakIBOutletSwiftRule: SwiftRule {
    
    let name: String = "IBOutlet marked as weak and private (except IBOutletCollection)"
    
    private var projectData: ProjectData
    private var failedString = ""
    
    init(projectData: ProjectData) {
        self.projectData = projectData
    }
    
    func run() -> GradeType {
        for (fileName, fileComponents) in projectData.applicationComponents {
            fileComponents.forEach {
                if $0.contains("IBOutlet") && !$0.contains("weak") && !$0.contains("IBOutletCollection") {
                    failedString += formattedFailedString(fileName: fileName, fileLine: $0)
                }
            }
        }
        return (failedString == "") ? .pass : .fail(failedString)
    }
}
