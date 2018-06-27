//
//  ProjectXMLParser.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 6/27/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

struct ProjectXMLParser {

    /// Parses an XML file, such as an Info.plist, into a readable dictionary using the string as the source path of
    /// the XML file.
    ///
    /// - Returns: Dictionary of parsed XML data.
    static func parse(xml: [String]) -> [String : Any]? {
        guard let xmlData = xml.joined().data(using: .utf32) else {
            return nil
        }
        var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
        do {
            return try PropertyListSerialization.propertyList(from: xmlData,
                                                              options: .mutableContainersAndLeaves,
                                                              format: &propertyListFormat) as? [String : Any]
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
        }
        return nil
    }

}
