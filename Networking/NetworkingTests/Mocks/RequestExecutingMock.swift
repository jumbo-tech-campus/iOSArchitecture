//
//  RequestExecutingMock.swift
//  NetworkingTests
//
//  Created by Ruud Puts on 06/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

@testable import Networking

class RequestExecutingMock: RequestExecuting {
    struct Stubs {
        var response: Response?
        var error: Error?
    }

    struct Captures {
        var execute: Execute?

        struct Execute {
            var request: Request
            var onCompletion: ((Response) -> (Void))?
            var onError: ((Error) -> (Void))?
        }
    }

    var stubs = Stubs()
    var captures = Captures()

    // RequestExecuting
    func execute(_ request: Request, onCompletion: ((Response) -> (Void))?, onError: ((Error) -> (Void))?) {
        captures.execute = Captures.Execute(request: request, onCompletion: onCompletion, onError: onError)

        if let error = stubs.error {
            onError?(error)
        }
        else if let response = stubs.response {
            onCompletion?(response)
        }
    }
}
