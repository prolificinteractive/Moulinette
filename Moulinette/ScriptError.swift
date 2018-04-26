//
//  ScriptError.swift
//  Moulinette-2.0
//
//  Created by Adam Tecle on 8/17/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Represents an error resulting from running a script
///
/// - failed: Script failed with error message
enum ScriptError: Error {
    case failed(String)
}
