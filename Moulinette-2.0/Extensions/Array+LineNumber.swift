//
//  Array+LineNumber.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 3/26/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

extension Array where Element == String {

    func lineNumberFor(_ line: String) -> Int? {
        if let index = index(of: line) {
            return index + 1
        }
        return nil
    }
}
