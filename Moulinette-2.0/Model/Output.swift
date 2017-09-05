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
    static var scoreKey = "score"
    static var identifierKey = "bundleIdentifier"
    static var collectionKey = "collections"
    static var weightKey = "weight"
    static var versionKey = "version"
    
    // MARK: - Private properties

    private var values: [String: Any] = [:]
    
    // MARK: - Init/Deinit functions

    init(with identifier: String, projectName: String) {
        values[Output.identifierKey] = identifier
        values[Output.projectNameKey] = projectName
        
        // Moulinette output version.
        values[Output.versionKey] = 1.0
    }
    
    // MARK: - Public functions

    func record(collection: String, rule: String, score: Double, weight: Double) {
        var rules = rulesDictionary()
        if rules[collection] == nil {
            rules[collection] = [String: [String: Double]]()
        }
        rules[collection]?[rule] = [Output.scoreKey: score,
                       Output.weightKey: weight]
        values[Output.collectionKey] = rules
    }
    
    func record(overallScore: Int) {
        values[Output.scoreKey] = overallScore
    }
    
    func representation() -> JSON {
        return values
    }
    
    func description() -> String {
        var output = "Running PiOS Rules for " + (values[Output.projectNameKey] as! String) + ":" + "\n"
        
        guard let collections = values[Output.collectionKey] as? [String: [String: [String: Double]]] else {
            return "Error building the Moulinette's description."
        }
        
        for collection in collections {
            output += "\(collection.key):\n"
            
            var iterator = collection.value.makeIterator()
            while let item = iterator.next() {
                guard let score = item.value[Output.scoreKey],
                    let weight = item.value[Output.weightKey] else {
                        continue
                }
                output += " - " + item.key + ": " + String(describing: score) + " / " + String(describing: weight) + "\n"
            }
        }
        

        output += "Score: " + String(values[Output.scoreKey] as! Int) + "\n"
        return output
    }
    
    // MARK: - Private functions
    
    private func rulesDictionary() -> [String: [String: [String: Double]]] {
        guard let rules = values[Output.collectionKey] as? [String: [String: [String: Double]]] else {
            return [String: [String: [String: Double]]]()
        }
        
        return rules
    }
    
}
