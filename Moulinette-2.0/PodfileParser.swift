//
//  PodfileParser.swift
//  Moulinette-2.0
//
//  Created by Adam Tecle on 7/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// Defines a parser for a podfile, represented by an array of strings
struct PodfileParser {

    /// Parses a Podfile and executes lineCompletion for each line that declares a new CocoaPod
    ///
    /// - Parameters:
    ///   - podfile: A Podfile represented by an array of strings, where each item is a line in the Podfile
    ///   - lineCompletion: A closure to be executed when a CocoaPod is found. The tokens array is an array of words
    ///     from the line that the pod was found on.
    static func parse(_ podfile: [String], lineCompletion: @escaping ((_ tokens: [String], _ line: String) -> Void)) {
        for line in podfile {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            let tokens = trimmed.components(separatedBy: " ")
            if let firstToken = tokens.first, firstToken == "pod" {
                lineCompletion(tokens, line)
            }
        }
    }
    
}
