//
//  Request.swift
//  Networking
//
//  Created by Ruud Puts on 02/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

@objc
class Request: NSObject {
    var method: Method
    var url: String
    var headers: [String: String]?
    var data: Data?

    public enum Method: String {
        case get
        case post
        case put
        case delete
    }

    init(url: String, method: Method, headers: [String: String]?, data: Data?) {
        self.url = url
        self.method = method
        self.headers = headers
        self.data = data
    }

    convenience init(host: String,
                     path: String,
                     parameters: [String: String]?,
                     method: Method,
                     headers: [String: String]?,
                     data: Data?) {
        let url = "\(host)/\(path)".inject(parameters: parameters ?? [:])

        self.init(url: url, method: method, headers: headers, data: data)
    }
}
