//
//  FileType.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

enum FileType {
    case swiftClass
    case swiftEnum
    case swiftProtocol
    case swiftStruct
    
    static func type(fileLine: String) -> FileType? {
        guard !fileLine.contains("//") && !fileLine.contains("private") else {
            return nil
        }
        
        if fileLine.contains("class ") &&
            !fileLine.contains("class func") &&
            !fileLine.contains("protocol") &&
            !fileLine.contains("\"") {
            
            return .swiftClass
        }
        
        if fileLine.contains("enum ") {
            return .swiftEnum
        }
        
        if fileLine.contains("protocol ") {
            return .swiftProtocol
        }
        
        if fileLine.contains("struct ") {
            return .swiftStruct
        }
        return nil
    }
    
    static func value(fileType: FileType) -> String {
        switch fileType {
        case .swiftClass:
            return "class"
        case .swiftEnum:
            return "enum"
        case .swiftProtocol:
            return "protocol"
        case .swiftStruct:
            return "struct"
        }
    }
}
