//
//  ProjectData.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 5/30/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

typealias FileComponents = [String]
typealias ClassInfo = (className: String, subClassName: String?)
typealias LineOffsetInfo = (lineNumber: Int, isInsertion: Bool)

final class ProjectData: SwiftData {
    
    var applicationComponents: ApplicationComponents
    var classInfo = [ClassInfo]()
    let path: String

    private(set) var correctedProjectComponents = ProjectComponents()
    private var fileCorrections = [FileCorrection]()

    init(path: String, applicationComponents: ApplicationComponents) {
        self.path = path
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

    func add(corrections: [FileCorrection]) {
        fileCorrections.append(contentsOf: corrections)
    }

    /// Applies the file correction with the correct line index.
    ///
    /// - Parameter fileCorrections: File corrections to apply.
    func applyCorrections() {
        correctedProjectComponents = applicationComponents.components
        var fileLineOffset = [String: [LineOffsetInfo]]()

        for correction in fileCorrections {
            if fileLineOffset[correction.fileName] == nil {
                fileLineOffset[correction.fileName] = []
            }

            if let customString = correction.customString {
                correctedProjectComponents[correction.fileName]?[correction.lineNumber-1] = customString
            }

            for lineNumber in correction.lineDeletions ?? [] {
                let offset = lineOffset(lineNumber: lineNumber, lineOffsetInfo: fileLineOffset[correction.fileName])

                let deletionIndex = max(lineNumber - 1 + offset, 0)
                correctedProjectComponents[correction.fileName]?.remove(at: deletionIndex)
                fileLineOffset[correction.fileName]?.append((lineNumber, false))
            }

            for line in correction.lineInsertions ?? [] {
                let offset = lineOffset(lineNumber: line.lineNumber, lineOffsetInfo: fileLineOffset[correction.fileName])

                let insertionIndex = line.lineNumber - 1 + offset
                correctedProjectComponents[correction.fileName]?.insert(line.codeString, at: insertionIndex)
                fileLineOffset[correction.fileName]?.append((line.lineNumber, true))
            }
        }
    }

    private func lineOffset(lineNumber: Int, lineOffsetInfo: [LineOffsetInfo]?) -> Int {
        var offset = 0
        for offsetInfo in lineOffsetInfo ?? [] {
            if offsetInfo.lineNumber < lineNumber {
                offset += offsetInfo.isInsertion ? 1 : -1
            }
        }
        return offset
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
