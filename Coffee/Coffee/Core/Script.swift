//
//  Script.swift
//  Coffee
//
//  Created by Morgan Collino on 9/12/17.
//  Copyright © 2017 Morgan Collino. All rights reserved.
//

import Cocoa

// Represents an error resulting from running a script
///
/// - failed: Script failed with error message
enum ScriptError: Error {
    case failed(String)
}

/// Provides an API for interfacing with command line
internal struct Script {
    
    let command: String
    
    init(command: String) {
        self.command = command
    }
    
    @discardableResult func execute(args: [String] = []) throws -> String {
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        let task = Process()
        
        task.launchPath = command
        task.arguments = args
        
        task.standardOutput = outputPipe
        task.standardError = errorPipe;
        task.launch()
        
        let outputPipeData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let outputString = String(data: outputPipeData, encoding: String.Encoding.utf8)
        let errorPipeData = errorPipe.fileHandleForReading.readDataToEndOfFile()
        let errorString = String(data: errorPipeData, encoding: String.Encoding.utf8)
        
        if let output = outputString {
            return output
        }
        
        throw ScriptError.failed(errorString ?? "")
    }
    
}
