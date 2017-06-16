//
//  StringExtension.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

extension String {
    
    func split(at string: String) -> (leftString: String, rightString: String)? {
        if let range = range(of: string)  {
            let leftString = substring(with: Range(uncheckedBounds: (lower: startIndex, upper: range.lowerBound)))
            let rightString = substring(with: Range(uncheckedBounds: (lower: range.upperBound, upper: endIndex)))
            return (leftString.trimmingCharacters(in: .whitespaces), rightString.trimmingCharacters(in: .whitespaces))
        }
        return nil
    }
    
    func stringBetween(startString: String, endString: String) -> String? {
        if let startRange = range(of: startString),
            let endRange = range(of: endString),
            startRange.upperBound < endRange.lowerBound {
            
            return substring(with: Range(uncheckedBounds: (lower: startRange.upperBound, upper: endRange.lowerBound)))
        }
        return nil
    }
    
    func removeLeading(startWith token: String) -> String {
        var string = self
        while let range = range(of: token) {
            string = substring(with: Range(uncheckedBounds: (lower: range.upperBound, upper: string.endIndex)))
        }
        return string
    }
    
    /// Returns string with all characters after and including the token removed.
    ///
    /// - Parameter token: Token to search for.
    /// - Returns: String that has all characters after the token removed.
    func removeTrailing(startWith token: String) -> String {
        if let token = range(of: token) {
            var newString = self
            newString.removeSubrange(token.lowerBound..<endIndex)
            return newString
        }
        return self
    }
    
    /// Returns a string without white spaces.
    ///
    /// - Returns: String without white spaces.
    func stringWithoutWhitespaces() -> String {
        return replacingOccurrences(of: " ", with: "")
    }
    
    /// Determines if the line is a class.
    ///
    /// - Returns: A flag to determine if the current string is a class.
    func isProjectClass() -> Bool {
        return (contains("class") &&
            !contains("//") &&
            !contains("protocol") &&
            !contains("func"))
    }
    
    func className() -> String? {
        let fileLine = stringWithoutWhitespaces()
        if let className = fileLine.stringBetween(startString: "class", endString: ":") {
            return className
        } else if let className = fileLine.stringBetween(startString: "class", endString: "{") {
            return className
        }
        return nil
    }
    
    func subClassName() -> String? {
        let fileLine = stringWithoutWhitespaces()
        if let subClassName = fileLine.stringBetween(startString: ":", endString: ",") {
            return subClassName
        } else if let subClassName = fileLine.stringBetween(startString: ":", endString: "{") {
            return subClassName
        }
        return nil
    }

    func isTodoComment() -> Bool {
        return self.isComment() && self.contains("TODO")
    }

    func isComment() -> Bool {
        return Regex.commentRegex().hasMatch(input: self)
    }

    func hasPivotalStory() -> Bool {
        return self.contains("https://www.pivotaltracker.com/")
    }

}
