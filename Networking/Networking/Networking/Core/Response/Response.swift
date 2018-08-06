//
//  Response.swift
//  Networking
//
//  Created by Ruud Puts on 02/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

@objc
class Response: NSObject {
    var data: Data?
    var statusCode: Int

    init(data: Data?, statusCode: Int) {
        self.data = data
        self.statusCode = statusCode
    }
}
