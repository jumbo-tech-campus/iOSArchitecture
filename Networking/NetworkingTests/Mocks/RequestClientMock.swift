//
//  RequestClientMock.swift
//  NetworkingTests
//
//  Created by Ruud Puts on 06/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

@testable import Networking

class RequestClientMock: RequestClient {
    struct Stubs {
        var response: Response?
        var error: RequestClientError?
    }

    struct Captures {
        var execute: Execute?

        struct Execute {
            var request: Request
            var completion: (Response?, RequestClientError?) -> Void
        }
    }

    var stubs = Stubs()
    var captures = Captures()

    // RequestClient

    func execute(_ request: Request, completion: @escaping (Response?, RequestClientError?) -> Void) {
        captures.execute = Captures.Execute(request: request, completion: completion)

        completion(stubs.response, stubs.error)
    }
}
