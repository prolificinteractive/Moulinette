//
//  main.swift
//  Coffee
//
//  Created by Morgan Collino on 9/12/17.
//  Copyright © 2017 Morgan Collino. All rights reserved.
//

import Foundation

let userDefaults = UserDefaults.standard.dictionaryRepresentation()

guard let moulinettePath = userDefaults["moulinettePath"] as? String,
    let projectDirectory = userDefaults["projectDirectory"] as? String else {
        print("Error: Missing parameter.")
        print("Eg: coffee -moulinettePath </$path/to/moulinette/binary/Moulinette-2.0> -projectDirectory </$path/to/projects/directory/>")
        exit(1)
}

print("####### COFFEE INCOMING #######")

let projects = [
    Project(identifier: "com.prolificinteractive.Hibbett", name: "Hibbet", silentMode: false, verbose: false, directory: projectDirectory + "/" + "hibbett-ios"),
    Project(identifier: "com.scotts.gro", name: "Gro", silentMode: false, verbose: false, directory: projectDirectory + "/" + "scotts-gro-ios"),
    Project(identifier: "com.hsn.HSNshop", name: "HSN", silentMode: false, verbose: false, directory: projectDirectory + "/" + "hsn-ios"),
    Project(identifier: "com.prolificinteractive.AMEX", name: "AMEX", silentMode: false, verbose: false, directory: projectDirectory + "/" + "amex-open-forum-ios"),
    Project(identifier: "com.gap.shopon", name: "Old Navy", silentMode: false, verbose: false, directory: projectDirectory + "/" + "old-navy"),
    Project(identifier: "com.soul-cycle.soulcycle", name: "SoulCycle", silentMode: false, verbose: false, directory: projectDirectory + "/" + "soulcycle-ios"),
]

let moulinette = Moulinette(path: moulinettePath)

projects.forEach { (project) in
    print("####### COFFEE FOR \(project.name.uppercased()) #######")

    moulinette.run(project: project)
    
    print("####### COFFEE FOR \(project.name.uppercased()) DONE #######")
}

print("####### COFFEE DONE #######")
exit(1)
