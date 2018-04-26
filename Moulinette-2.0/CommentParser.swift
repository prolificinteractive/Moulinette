//
//  CommentParser.swift
//  Moulinette
//
//  Created by Adam Tecle on 6/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Defines a parser for comments
struct CommentParser {

    static func parse(fileComponents: [String], onLineCompletion:((_ comment: String, _ line: String, _ lineNumber: Int) -> ())) {
        var comment = ""

        for index in 0..<fileComponents.count {
            let line = fileComponents[index]
            if line.isComment() {
                comment += line
                continue
            }

            if !comment.isEmpty {
                onLineCompletion(comment, line, index)
            }

            comment = ""
        }
    }

}
