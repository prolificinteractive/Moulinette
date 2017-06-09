//
//  APIEnvironment.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/9/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct APIEnvironment {
    
    var baseURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/4d/Cat_November_2010-1a.jpg")
    
    /// Generates the url from the base url.
    ///
    /// - Parameter endpoint: Endpoint to access.
    /// - Returns: Complete url.
    func url(endpoint: String) -> URL? {
        guard let endpoint = endpoint.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: endpoint, relativeTo: baseURL) else {
                return nil
        }
        return url
    }
}