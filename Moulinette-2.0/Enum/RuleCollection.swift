//
//  RuleType.swift
//  Moulinette-2.0
//
//  Created by Adam Tecle on 6/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Rule collection.
protocol RuleCollection {

    /// Description.
    var description: String { get }

    /// List of rules linked to the rule collection.
    ///
    /// - Parameter projectData: Project data.
    /// - Returns: List of rules.
    func rules(projectData: ProjectData) -> [SwiftRule]

}
