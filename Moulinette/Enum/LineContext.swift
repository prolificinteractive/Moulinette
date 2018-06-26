//
//  LineContext.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

enum LineContext {
    case none
    case structContext
    case dispatchMain
    case lazy
    case function
    case enumContext
    case completion
    case classContext
    case extensionContext
    case protocolContext
    case privateExtensionContext
    case initializer
    case computedVariable

    static func type(fileLine: String) -> LineContext? {
        
        if fileLine.contains("struct") {
            return .structContext
        }
        
        if fileLine.contains("func") {
            return .function
        }
        
        if fileLine.contains("DispatchQueue.main.async") {
            return .dispatchMain
        }
        
        if fileLine.contains("lazy") {
            return .lazy
        }
        
        if fileLine.contains("enum") {
            return .enumContext
        }
        
        if fileLine.stringWithoutWhitespaces().contains("{(") && fileLine.contains("in") ||
            (fileLine.stringWithoutWhitespaces().contains("{ [weak self]") && fileLine.contains("in")) {
            return .completion
        }

        if fileLine.contains("class ") && !fileLine.contains(": class ") {
            return .classContext
        }

        if fileLine.contains("extension ") {
            return extensionContext
        }

        if fileLine.contains("protocol ") {
            return protocolContext
        }

        if fileLine.contains("private extension ") {
            return privateExtensionContext
        }

        if fileLine.contains("init") {
            return initializer
        }

        if (fileLine.contains("var ") || fileLine.contains("let ")) &&
            (fileLine.contains(" = {") || fileLine.contains("{"))  {
            return computedVariable
        }

        return nil
    }

    func isBracketType() -> Bool {
        switch self {
        case .structContext, .function, .classContext, .initializer, .computedVariable, .completion:
            return true
        default:
            return false
        }
    }
}
