//
//  RequestClient.swift
//  Networking
//
//  Created by Ruud Puts on 02/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

protocol RequestClient {
    func execute(_ request: Request, completion: @escaping (Response?, RequestClientError?) -> Void)
}

enum RequestClientError: Error, Hashable {
    case generic(message: String)
    case invalidRequest
    case invalidResponse
    case noData
}
