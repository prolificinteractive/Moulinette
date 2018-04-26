//
//  Data+Codable.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 4/26/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

extension Data {

    func deserializeObject<T: Decodable>(completion: (T?, Error?)->()) {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(T.self, from: self)
            completion(object, nil)
        }
        catch {
            completion(nil, NetworkError.objectSerialization(reason: "Object Serialization Failed"))
        }
    }

    func deserializeArray<T: Decodable>(completion: ([T]?, Error?)->()) {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode([T].self, from: self)
            completion(object, nil)
        }
        catch {
            completion(nil, NetworkError.objectSerialization(reason: "Array Serialization Failed"))
        }
    }
}
