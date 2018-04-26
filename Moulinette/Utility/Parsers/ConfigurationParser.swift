//
//  ConfigurationParser.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 4/26/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

final class ConfigurationParser {

    /// Configuration File.
    var configFile: ConfigurationFile?

    /// Current Project Directory.
    static var projectDirectory: String = ""

    init(projectDirectory: String) {
        ConfigurationParser.projectDirectory = projectDirectory
        parseConfigurationFile(projectDirectory: projectDirectory)
    }
}

private extension ConfigurationParser {

    static func getEnvironmentVar(_ name: String) -> String? {
        guard let rawValue = getenv(name) else { return nil }
        return String(utf8String: rawValue)
    }

    func parseConfigurationFile(projectDirectory: String) {
        let fileToParse = projectDirectory + ".moulinette.configuration.json"

        do {
            let content = try String(contentsOfFile: fileToParse, encoding: String.Encoding.utf8)
            let fileLines = content.components(separatedBy: "\n")
            setupConfigurationFile(fileLines: fileLines)
        } catch {
            print("Error caught with message: \(error.localizedDescription)")
        }
    }

    func setupConfigurationFile(fileLines: [String]) {
        let configString = fileLines.joined()
        let configData = configString.data(using: .utf8)
        configData?.deserializeObject(completion: { (config, _) in
            self.configFile = config
        })
    }
}
