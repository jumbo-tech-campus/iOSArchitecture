//
//  RequestBuilding.swift
//  Networking
//
//  Created by Ruud Puts on 02/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

protocol RequestBuilding {
    func make(for apiCall: ApiCall) -> Request
    func specification(for apiCall: ApiCall) -> RequestSpecification
}

enum RequestBuildingError: Error {
    case notSupportedError(String)
}

extension RequestBuilding {
    func make(for apiCall: ApiCall) -> Request {
        let spec = specification(for: apiCall)

        return Request(
            host: spec.host,
            path: spec.path,
            parameters: spec.parameters,
            method: spec.method,
            data: spec.data
        )
    }
}
