//
//  AuditScore.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/9/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct AuditScore {
    
    let score: Int
    
    init?(json: JSON) {
        guard let score = json["Score"] as? Int else {
            return nil
        }
        self.score = score
    }
    
    init(score: Int) {
        self.score = score
    }
    
    func jsonSerialize() -> JSON {
        return ["Score" : score]
    }
}
