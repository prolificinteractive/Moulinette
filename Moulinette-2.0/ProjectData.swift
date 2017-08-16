//
//  ProjectData.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/30/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

typealias FileComponents = [String]
typealias ClassInfo = (className: String, subClassName: String?)

final class ProjectData: SwiftData {
    
    var applicationComponents: ApplicationComponents
    
    var classInfo = [ClassInfo]()

    init(applicationComponents: ApplicationComponents) {
        self.applicationComponents = applicationComponents
        parseAllClasses()
    }
    
    func subClassFound(className: String) -> Bool {
        for info in classInfo {
            if info.subClassName == className {
                return true
            }
        }
        return false
    }
    
    private func parseAllClasses() {
        for (_, fileComponents) in applicationComponents.components {
            fileComponents.forEach {
                if $0.isProjectClass(), let info = generateClassInfo(fileLine: $0) {
                    classInfo.append(info)
                }
            }
        }
    }
    
    private func generateClassInfo(fileLine: String) -> ClassInfo? {
        let name: String? = fileLine.className()
        let subClass: String? = fileLine.subClassName()
        
        if let name = name {
            return (name, subClass)
        }
        return nil
    }
}
