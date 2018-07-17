//
//  Array+LineNumber.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 3/26/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

extension Array where Element == String {

    func lineNumberFor(_ line: String) -> Int? {
        if let index = index(of: line) {
            return index + 1
        }
        return nil
    }

    /// Returns the line number above comments
    ///
    /// - Parameter violationLineNumber: Line number violation
    /// - Returns: The updated line number where there is no comment and whether an additional space should be added.
    func aboveCommentLineNumber(violationLineNumber: Int) -> (lineNumber: Int, insertTopSpace: Bool) {
        let startLineNumber = violationLineNumber-1
        let startIndex = startLineNumber-1
        for index in stride(from: startIndex, through: 0, by: -1) {
            let formattedString = self[index].replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
            if formattedString.isComment() {
                continue
            } else {
                return (index + 2, !formattedString.isEmpty)
            }
        }
        return (0, false)
    }

    func removeCommentEmptyStrings(lineNumber: Int) -> [Int] {
        let startIndex = Swift.max(lineNumber - 2, 0)
        var lineDeletions = [lineNumber]

        for index in stride(from: startIndex, through: 0, by: -1) {
            var currentLine = self[index]
            let lineNumber = index + 1

            if currentLine.isEmpty {
                lineDeletions.insert(lineNumber, at: 0)
                continue
            }

            guard currentLine.count >= 2 else {
                continue
            }

            let char1 = currentLine.remove(at: currentLine.startIndex)
            let char2 = currentLine.remove(at: currentLine.startIndex)

            if (char1 == "/" && char2 == "/") || (char1 == "/" && char2 == "*") {
                lineDeletions.insert(lineNumber, at: 0)
                continue
            } else {
                break
            }
        }
        return lineDeletions
    }

}
