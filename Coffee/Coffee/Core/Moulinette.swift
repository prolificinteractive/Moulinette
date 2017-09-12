//
//  Moulinette.swift
//  Coffee
//
//  Created by Morgan Collino on 9/12/17.
//  Copyright © 2017 Morgan Collino. All rights reserved.
//

import Foundation

struct Moulinette {
    
    let path: String
    
    func run(project: Project) {
        let args = transform(project: project)
        let command = path
        let script = Script(command: command)
        
        do {
            let output = try script.execute(args: args)
            print(output)
        } catch (let error) {
            print(error)
        }
    }
    
    // MARK: - Private methods
    
    private func transform(project: Project) -> [String] {
        var args = [String]()
        args.append("-projectName")
        args.append(project.name)
        args.append("-projectIdentifier")
        args.append(project.identifier)
        args.append("-projectDirectory")
        args.append(project.directory)
        args.append("-silent")
        args.append(Project.boolToString(bool: project.silentMode))
        args.append("-verbose")
        args.append(Project.boolToString(bool: project.verbose))
        
        return args
    }
    
}

// EG: /$path/Moulinette-2.0 -projectName "" -projectIdentifier "" -projectDirectory "" -silent "true" -verbose "true"
