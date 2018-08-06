//
//  UXApi.swift
//  Networking
//
//  Created by Ruud Puts on 02/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

class UxAPI: ApiConfiguring {
    let endpoint: String
    let apiVersion: String

    init(endpoint: String, apiVersion: String = "V3") {
        self.endpoint = endpoint
        self.apiVersion = apiVersion
    }

    var host: String {
        return "\(endpoint)/\(apiVersion)"
    }
}
