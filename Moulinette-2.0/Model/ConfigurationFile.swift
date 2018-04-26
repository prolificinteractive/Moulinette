//
//  ConfigurationFile.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 4/26/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

/// Configuration file for the project.
struct ConfigurationFile: Codable {

    /// Collection of the excluded rules
    let excludedRules: [String]
}
