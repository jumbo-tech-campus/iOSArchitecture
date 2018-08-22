//
//  RequestSpecification.swift
//  Networking
//
//  Created by Ruud Puts on 02/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

struct RequestSpecification {
    let host: String
    let path: String

    let method: Request.Method
    let parameters: [String: String]?

    let headers: [String: String]?

    let data: Data?

    init(host: String = "", path: String = "", method: Request.Method = .get, parameters: [String: String] = [:], headers: [String: String] = [:], data: Data? = nil) {
        self.host = host
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.data = data
    }
}

extension RequestSpecification: Equatable {
    static func == (lhs: RequestSpecification, rhs: RequestSpecification) -> Bool {
        return lhs.host == rhs.host
            && lhs.path == rhs.path
            && lhs.method == rhs.method
            && lhs.parameters == rhs.parameters
            && lhs.headers == rhs.headers
            && lhs.data == rhs.data
    }
}
