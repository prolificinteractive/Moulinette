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
    static var weightKey = "weight"
    
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
        rules[rule] = [Output.scoreKey: score,
                       Output.weightKey: weight]
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
            guard let score = item.value[Output.scoreKey],
                let weight = item.value[Output.weightKey] else {
                    continue
            }
            output += " - " + item.key + ": " + String(score) + " / " + String(weight) + "\n"
        }
        output += "Score: " + String(values[Output.scoreKey] as! Int) + "\n"
        return output
    }
    
    // MARK: - Private functions
    
    private func rulesDictionary() -> [String: [String: Double]] {
        guard let rules = values[Output.rulesKey] as? [String: [String: Double]] else {
            return [String: [String: Double]]()
        }
        
        return rules
    }
    
}
