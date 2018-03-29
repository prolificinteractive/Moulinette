//
//  FileCorrection.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 3/29/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

struct FileCorrection {
    let fileName: String

    let lineNumber: Int
    let customString: String?

    let lineInsertions: [Line]?
    let lineDeletions: [Int]?
}
