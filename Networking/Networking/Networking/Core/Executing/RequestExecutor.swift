//
//  RequestExecutor.swift
//  Networking
//
//  Created by Ruud Puts on 02/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation


@objc
protocol RequestExecuting {
    func execute(_ request: Request, onCompletion: ((Response) -> (Void))?, onError: ((Error) -> (Void))?)
}

// RequestExecutor could be a wrapper to add i.e. Reactive programming to the network layer.

class RequestExecutor: RequestExecuting {
    private let requestClient: RequestClient

    init(requestClient: RequestClient = URLSession.shared) {
        self.requestClient = requestClient
    }

    func execute(_ request: Request, onCompletion: ((Response) -> (Void))?, onError: ((Error) -> (Void))?) {
        self.requestClient.execute(request) {
            guard $1 == nil else {
                onError?($1!)
                return
            }

            guard let response = $0 else {
                return
            }

            onCompletion?(response)
        }
    }
}
