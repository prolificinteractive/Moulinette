//
//  APIEnvironment.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/9/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct APIEnvironment {
    
    let debugMode: Bool
    
    var baseURL = URL(string: "http://moulinette.prolific.io/api/")
    var devBaseURL = URL(string: "http://34.230.27.50/api/")
    
    init(debugMode: Bool) {
        self.debugMode = debugMode
    }
    
    /// Generates the url from the base url.
    ///
    /// - Parameter endpoint: Endpoint to access.
    /// - Returns: Complete url.
    func url(endpoint: String) -> URL? {
        let baseURL = debugMode ? self.devBaseURL : self.baseURL
        
        guard let endpoint = endpoint.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: endpoint, relativeTo: baseURL) else {
                return nil
        }
        return url
    }
}
