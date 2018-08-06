//
//  RequestBuildingMock.swift
//  NetworkingTests
//
//  Created by Ruud Puts on 06/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

@testable import Networking

class RequestBuildingMock: RequestBuilding {
    struct Stubs {
        var specification: RequestSpecification?
        var make: Request?
    }

    struct Captures {
        var specification: ApiCall?
        var make: ApiCall?
    }

    var stubs = Stubs()
    var captures = Captures()

    // RequestBuildingMock

    func specification(for apiCall: ApiCall) -> RequestSpecification {
        captures.specification = apiCall

        return stubs.specification!
    }

    func make(for apiCall: ApiCall) -> Request {
        captures.make = apiCall

        return stubs.make!
    }
}
