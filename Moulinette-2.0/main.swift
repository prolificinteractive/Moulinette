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
var projectData = ProjectData(applicationComponents: applicationFileComponents)

// Run PiOS Rules
let output = PIOSAudit(projectData: projectData).runRules()

if settings.debugMode {
    print("############### MOULINETTE_2.0 OUTPUT ###############")
    print("Moulinette 2.0")
    print(output.description())
}

if settings.silentMode == false {
    NetworkRequester().submitAuditScore(score: output.representation(), completion: ({ (json, error) in
        if let error = error {
            // Display error?
            return
        }
        
        guard let url = json?["url"],
            let score = output.representation()[Output.scoreKey] else {
                print("No url return from the JSO or score doesn't exist in the output representation.")
                return
        }
        print("Score:\(score)")
        print("Url:\(url)")
        exit(1)
    }))
} else {
    exit(1)
}
