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
    
    private var environment = APIEnvironment()
    
    func submitAuditScore(score: JSON) {
        guard let url = environment.baseURL else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        // Parameters
        let parameters = score
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        // Thread lock
        let sema = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                print("*****error")
                sema.signal()
                return
            }
//            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("*****Data: \(String(describing: response))")
            sema.signal()
        }
        
        // Network call
        task.resume()
        sema.wait()
        print("Completed")
    }
}
