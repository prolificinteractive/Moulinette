//
//  Output.swift
//  Moulinette-2.0
//
//  Created by Morgan Collino on 7/20/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// PiOS Output.
final class Output {
    
    // MARK: - Public properties

    static var projectNameKey = "projectName"
    static var rulesKey = "rules"
    static var scoreKey = "score"
    static var identifierKey = "bundleIdentifier"
    
    // MARK: - Private properties

    private var values: [String: Any] = [:]
    
    // MARK: - Init/Deinit functions

    init(with identifier: String, projectName: String) {
        values[Output.identifierKey] = identifier
        values[Output.projectNameKey] = projectName
    }
    
    // MARK: - Public functions

    func record(rule: String, score: Double, weight: Double) {
        var rules = rulesDictionary()
        rules[rule] = (score, weight)
        values[Output.rulesKey] = rules
    }
    
    func record(overallScore: Int) {
        values[Output.scoreKey] = overallScore
    }
    
    func representation() -> JSON {
        return values
    }
    
    func description() -> String {
        var output = "Running PiOS Rules for " + (values[Output.projectNameKey] as! String) + ":" + "\n"
        let rules = rulesDictionary()
        var iterator = rules.makeIterator()
        while let item = iterator.next() {
            output += " - " + item.key + ": " + String(item.value.0) + " / " + String(item.value.1) + "\n"
        }
        output += "Score: " + String(values[Output.scoreKey] as! Int) + "\n"
        return output
    }
    
    // MARK: - Private functions
    
    private func rulesDictionary() -> [String: (Double, Double)] {
        guard let rules = values[Output.rulesKey] as? [String: (Double, Double)] else {
            return [String: (Double, Double)]()
        }
        
        return rules
    }
    
}
