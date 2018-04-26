//
//  CorrectableSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 4/12/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

protocol CorrectableSwiftRule: SwiftRule {

    func correct(projectData: ProjectData) -> [FileCorrection]
}
