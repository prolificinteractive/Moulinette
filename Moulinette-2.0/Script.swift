//
//  Script.swift
//  Moulinette
//
//  Created by Christopher Jones on 3/3/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Cocoa

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
