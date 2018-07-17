//
//  main.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 5/26/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

// Project Settings and Config File
let settings = ProjectSettings()
let config = ConfigurationParser(projectDirectory: settings.projectDirectory).configFile

// Parse Project
let projectParser = ProjectParser(configFile: config)
let applicationFileComponents = projectParser.applicationComponents()

// Generate data store
var projectData = ProjectData(path: settings.projectDirectory, applicationComponents: applicationFileComponents)

// Run PiOS Rules

let audit = PIOSAudit(projectData: projectData, configurationFile: config)
let output = audit.runRules()
audit.autoCorrect()

if settings.debugMode {
    print("############### MOULINETTE AUDITOR v0.1.4 ###############")
    if settings.xcodePlugin {
        print(output.xcodeDescription())
    } else {
        print(output.description())
    }
    print("################## MOULINETTE AUDITOR ##################")
}

if settings.silentMode == false,
    let authToken = settings.authToken {
    NetworkRequester(debugMode: settings.debugMode).submitAuditScore(score: output.representation(),
                                        authToken: authToken,
                                        completion: ({ (json, error) in
        if let error = error {
            print(error)
            exit(0)
        }

        guard let url = json?["url"],
            let score = output.representation()[Output.scoreKey] else {
                print("No url returned from the JSON or score doesn't exist in the output representation.")
                exit(0)
        }
        print("Score:\(score)")
        print("Url:\(url)")
        exit(0)
    }))
} else {
    exit(0)
}
