//
//  ResponseData.swift
//  Networking
//
//  Created by Ruud Puts on 03/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

struct ResponseData<Object: Codable>: Codable {
    var data: Object
}

struct PaginatedResponseData<Object: Codable>: Codable {
    var offset: Int
    var total: Int
    var data: [Object]
}
