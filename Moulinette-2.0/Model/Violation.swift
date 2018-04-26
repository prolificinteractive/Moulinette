//
//  Violation.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 3/28/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

struct Violation {
    let fileName: String
    let lineNumber: Int?
    let description: String
    let nameId: String
}

extension Violation {

    /// Formatted Description of for the violation.
    ///
    /// - Returns: Formatted description.
    func formattedDescription() -> String {
        return "\(description) [\(nameId)]"
    }
}
