//
//  String+Substring.swift
//  Moulinette-2.0
//
//  Created by Adam Tecle on 6/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Defines helper functions on objects of type String to create various substrings
extension String {

    /// Returns the string separated by the provided `string` parameter as a tuple
    ///
    /// - Parameter string: The separator string
    /// - Returns: The string separated by the provided `string` parameter as a tuple
    func split(at string: String) -> (leftString: String, rightString: String)? {
        if let range = range(of: string)  {
            let leftString = substring(with: Range(uncheckedBounds: (lower: startIndex, upper: range.lowerBound)))
            let rightString = substring(with: Range(uncheckedBounds: (lower: range.upperBound, upper: endIndex)))
            return (leftString.trimmingCharacters(in: .whitespaces), rightString.trimmingCharacters(in: .whitespaces))
        }
        return nil
    }

    /// Returns the substring that falls between the provided startString and endString
    ///
    /// - Parameters:
    ///   - startString: The start string
    ///   - endString: The end string
    /// - Returns: The substring that falls between startString and endString
    func stringBetween(startString: String, endString: String) -> String? {
        if let startRange = range(of: startString),
            let endRange = range(of: endString),
            startRange.upperBound < endRange.lowerBound {

            return substring(with: Range(uncheckedBounds: (lower: startRange.upperBound, upper: endRange.lowerBound)))
        }
        return nil
    }

    /// Returns the substring that contains the characters after first occurrence of the provided token.
    ///
    /// - Parameter token: The token
    /// - Returns: The substring that contains the characters after first occurrence of the provided token.
    func removeLeading(startWith token: String) -> String {
        var string = self
        while let range = range(of: token) {
            string = substring(with: Range(uncheckedBounds: (lower: range.upperBound, upper: string.endIndex)))
        }
        return string
    }

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

    /// Returns the file name if the String is a path to a file.
    ///
    /// - Returns: The file name if the String is a path to a file, nil if not.
    func fileName() -> String? {
        guard let file = components(separatedBy: "/").last else {
            return nil
        }

        return file
    }

    /// Returns true if the String is a file that should be parsed
    ///
    /// - Returns: True if the String is a file that should be parsed, false if it should not be parsed.
    func isValidFile() -> Bool {
        var valid = false
        Constants.validNonSwiftFiles.forEach { file in
            valid = file == self ? true : valid
        }

        return hasValidFileExtension() || valid
    }

    /// Has valid file extension.
    ///
    /// - Returns: Boolean value. True if value, False else.
    func hasValidFileExtension() -> Bool {
        var valid = false
        let nsstring = self as NSString
        for fileExtension in Constants.fileExtensions {
            valid = valid || nsstring.pathExtension == fileExtension
        }

        return valid
    }

    func writeToFile(directory: String) {
        guard let fileURL = URL(string: directory) else {
            print("Error: Not a valid url: " + directory)
            return
        }

        do {
            try write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch let error {
            print("Error: " + error.localizedDescription)
        }
    }
    
}
