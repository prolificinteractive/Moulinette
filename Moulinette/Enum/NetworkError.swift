//
//  NetworkError.swift
//  Moulinette
//
//  Created by Jonathan Samudio on 4/26/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case network(error: Error)
    case jsonSerialization
    case objectSerialization(reason: String)
    case urlInvalid
}
