//
//  SwiftData.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/16/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

protocol SwiftData {
    
    var applicationComponents: ApplicationComponents { get set }
    
    var classInfo: [ClassInfo] { get set }
    
    var path: String { get }
    
    func subClassFound(className: String) -> Bool
}
