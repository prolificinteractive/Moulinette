//
//  GradeType.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/30/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

enum GradeType {
    case pass
    case fail(String)
    
    func gradeText() -> String {
        switch self {
        case .pass:
            return "Passed!"
        case let .fail(reason):
            return "Failed! \n" + reason
        }
    }
}
