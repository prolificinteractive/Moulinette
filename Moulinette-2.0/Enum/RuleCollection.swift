//
//  RuleType.swift
//  Moulinette-2.0
//
//  Created by Adam Tecle on 6/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

protocol RuleCollection {

    func rules(projectData: ProjectData) -> [SwiftRule]
}
