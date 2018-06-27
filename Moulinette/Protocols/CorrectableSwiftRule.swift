//
//  CorrectableSwiftRule.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 4/12/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

protocol CorrectableSwiftRule: SwiftRule {

    /// Corrects the swift rule for any violations that are found.
    ///
    /// - Parameter projectData: Project data of the application.
    /// - Returns: Array of necessary file corrections.
    func correct(projectData: ProjectData) -> [FileCorrection]
    
}
