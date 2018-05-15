//
//  StringExtension.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Defines helper functions on objects of type String to parse information about the Swift code 
/// contained in the string
extension String {
    
    /// Parses an XML file, such as an Info.plist, into a readable dictionary using the string as the source path of 
    /// the XML file.
    ///
    /// - Returns: Dictionary of parsed XML data.
    func parsedXMLDictionary<T>() -> [String : T]? {
        var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
        var plistData: [String : T]?
        
        if let plistXML = FileManager.default.contents(atPath: self) {
            do {
                plistData = try PropertyListSerialization.propertyList(from: plistXML,
                                                                       options: .mutableContainersAndLeaves,
                                                                       format: &propertyListFormat) as? [String : T]
            } catch {
                print("Error reading plist: \(error), format: \(propertyListFormat)")
            }
        }
        return plistData
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
    
    /// Returns the class name in a string containing Swift code.
    ///
    /// - Returns: The class name in a string containing Swift code.
    func className() -> String? {
        if let className = stringBetween(startString: "class ", endString: ":") {
            return className.stringWithoutWhitespaces()
        } else if let className = stringBetween(startString: "class ", endString: "{") {
            return className.stringWithoutWhitespaces()
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
        return self.isComment() && self.lowercased().contains("todo")
    }

    /// Returns true if the string containing Swift code is a comment.
    ///
    /// - Returns: True if the string containing Swift code is a comment.
    func isComment() -> Bool {
        return Regex.commentRegex().hasMatch(input: self) || self.components(separatedBy: " ").contains("*")
    }

    /// Returns true if the string containing Swift code has a pivotal story link.
    ///
    /// - Returns: True if the string containing Swift code has a pivotal story link.
    func hasPivotalStory() -> Bool {
        return self.contains(Constants.URL.pivotal)
    }

}
