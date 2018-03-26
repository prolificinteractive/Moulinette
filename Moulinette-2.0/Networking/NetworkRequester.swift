//
//  NetworkRequester.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 6/9/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

final class NetworkRequester {
    
    private var environment: APIEnvironment
    
    init(debugMode: Bool) {
        environment = APIEnvironment(debugMode: debugMode)
    }
    
    func submitAuditScore(score: JSON, authToken: String, completion: @escaping ([String: Any]?, NSError?) -> Void) {
        guard let url = environment.url(endpoint: "report") else {
            completion(nil, NSError())
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.setValue("application/json;", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        // Parameters
        let parameters = score
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error)
        }
        
        // Thread lock
        let sema = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            do {
                guard let data = data, let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else {
                    print("Data or json response missing.")
                    return
                }
                completion(json, nil)
                return
            } catch let error as NSError {
                completion(nil, error)
            }
            
            sema.signal()
        }
        
        // Network call
        task.resume()
        sema.wait()
        print("Completed")
    }
}
