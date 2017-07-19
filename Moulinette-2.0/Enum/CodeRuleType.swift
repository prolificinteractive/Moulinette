//
//  CodeRuleType.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct CodeConventionRuleCollection: RuleCollection {
    
    func rules(projectData: ProjectData) -> [SwiftRule] {
        return [
                CompletionWeakSwiftRule(projectData: projectData),
        ]
    }
}
