//
//  main.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/26/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

// Dev Branch: git checkout chore/remove_selfs
print("############### MOULINETTE_2.0 OUTPUT ###############")
print("Moulinette 2.0")

let settings = ProjectSettings()

// Parse Project
let projectParser = ProjectParser()
let applicationFileComponents = projectParser.applicationComponents()

// Generate data store
var projectData = ProjectData(applicationComponents: applicationFileComponents)

// Run PiOS Rules
let output = PIOSAudit(projectData: projectData).runRules()

print(output.description())
print(output.representation())
//NetworkRequester().submitAuditScore(score: AuditScore(score: 10))
