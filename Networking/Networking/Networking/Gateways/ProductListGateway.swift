//
//  ProductListGateway.swift
//  Networking
//
//  Created by Ruud Puts on 03/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

@objc
class ProductListGateway: NSObject, RequestGateway {
    var builder: RequestBuilding
    var executor: RequestExecuting
    var parser: ResponseParsing

    required init(builder: RequestBuilding, executor: RequestExecuting, parser: ResponseParsing) {
        self.builder = builder
        self.executor = executor
        self.parser = parser
    }

    func execute(completion: @escaping ([Product]) -> (Void)) {
        let request = builder.make(for: .product(.list))

        executor.execute(request, onCompletion: { response in
            do {
                completion(try self.parser.parseProducts(from: response))
            }
            catch {
                NSLog("Parsing error: \(error.localizedDescription)")
                completion([])
            }
        }, onError: { error in
            print("Erorr while fetching product list:\(error.localizedDescription)")
        })
    }

    func objcExecute(completion: @escaping (Any) -> (Void)) {
        execute(completion: completion)
    }
}
