//
//  AuditGrader.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

protocol AuditGrader {
    
    func violationFound(fileName: String, description: String)
    
    func generateGrade() -> AuditGrade
}
