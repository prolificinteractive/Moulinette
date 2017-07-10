//
//  StringExtension.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Defines helper functions on objects of type String to parse information about the Swift code 
/// contained in the string
extension String {

    /// Determines if the line is a class.
    ///
    /// - Returns: A flag to determine if the current string is a class.
    func isProjectClass() -> Bool {
        return (contains("class") &&
            !contains("//") &&
            !contains("protocol") &&
            !contains("func"))
    }
    
    /// Returns the class name in a string containing Swift code.
    ///
    /// - Returns: The class name in a string containing Swift code.
    func className() -> String? {
        let fileLine = stringWithoutWhitespaces()
        if let className = fileLine.stringBetween(startString: "class", endString: ":") {
            return className
        } else if let className = fileLine.stringBetween(startString: "class", endString: "{") {
            return className
        }
        return nil
    }
    
    /// Returns the subclass name in a string containing Swift code.
    ///
    /// - Returns: The subclass name in a string containing Swift code
    func subClassName() -> String? {
        let fileLine = stringWithoutWhitespaces()
        if let subClassName = fileLine.stringBetween(startString: ":", endString: ",") {
            return subClassName
        } else if let subClassName = fileLine.stringBetween(startString: ":", endString: "{") {
            return subClassName
        }
        return nil
    }

    /// Returns true if the string containing Swift code has a TODO comment.
    ///
    /// - Returns: True if the string containing Swift code has a TODO comment
    func isTodoComment() -> Bool {
        return self.isComment() && self.contains("TODO")
    }

    /// Returns true if the string containing Swift code is a comment.
    ///
    /// - Returns: True if the string containing Swift code is a comment.
    func isComment() -> Bool {
        return Regex.commentRegex().hasMatch(input: self)
    }

    /// Returns true if the string containing Swift code has a pivotal story link.
    ///
    /// - Returns: True if the string containing Swift code has a pivotal story link.
    func hasPivotalStory() -> Bool {
        return self.contains(Constants.URL.pivotal)
    }

}
