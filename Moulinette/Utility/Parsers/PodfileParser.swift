//
//  PodfileParser.swift
//  Moulinette
//
//  Created by Adam Tecle on 7/21/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// Defines a parser for a podfile, represented by an array of strings
struct PodfileParser {

    /// Parses a podfile and executes completion block that takes
    ///
    /// - Parameters:
    ///   - podfile: A podfile represented by an array of strings
    ///   - onPodFound: A closure executed when a pod specification is found. Takes as parameters 
    ///   the line separated by whitespace, and the line.
    static func parse(_ podfile: [String], onPodFound: @escaping ((_ tokens: [String], _ line: String, _ lineNumber: Int?) -> Void)) {
        for line in podfile {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            let tokens = trimmed.components(separatedBy: " ")
            if let firstToken = tokens.first, firstToken == "pod" {
                onPodFound(tokens, line, podfile.lineNumberFor(line))
            }
        }
    }
    
}
