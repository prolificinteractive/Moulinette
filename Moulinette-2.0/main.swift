//
//  main.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/26/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

// Dev Branch: git checkout chore/remove_selfs

print("Moulinette 2.0")

let settings = ProjectSettings()

// Parse Project
let projectParser = ProjectParser()
let applicationFileComponents = projectParser.applicationComponents()

// Generate data store
var projectData = ProjectData(applicationComponents: applicationFileComponents)

// Run PiOS Rules
let auditScore = PIOSAudit(projectData: projectData).runRules()

//NetworkRequester().submitAuditScore(score: AuditScore(score: 10))
