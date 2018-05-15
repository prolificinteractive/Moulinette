//
//  OldCommentStyleCheck.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 5/15/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

final class OldCommentStyleCheck {

    private(set) var insideCommentContext = false

    func check(line: String) {
        if line.contains("/**") {
            insideCommentContext = true
            return
        }

        if line.contains("*/") {
            insideCommentContext = false
        }
    }
}
