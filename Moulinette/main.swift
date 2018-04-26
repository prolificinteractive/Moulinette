//
//  main.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/26/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

let settings = ProjectSettings()

// Parse Project
let projectParser = ProjectParser()
let applicationFileComponents = projectParser.applicationComponents()

// Generate data store
var projectData = ProjectData(path: settings.projectDirectory, applicationComponents: applicationFileComponents)

// Run PiOS Rules
let output = PIOSAudit(projectData: projectData).runRules()

if settings.debugMode {
    print("############### MOULINETTE_2.0 OUTPUT ###############")
    print("Moulinette 2.0")
    print(output.description())
}

if settings.silentMode == false,
    let authToken = settings.authToken {
    NetworkRequester(debugMode: settings.debugMode).submitAuditScore(score: output.representation(),
                                        authToken: authToken,
                                        completion: ({ (json, error) in
        if let _ = error {
            // Display error?
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
