//
//  ProductDetailsGateway.swift
//  Networking
//
//  Created by Ruud Puts on 03/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

@objc
class ProductDetailsGateway: NSObject, RequestGateway {
    var builder: RequestBuilding
    var executor: RequestExecuting
    var parser: ResponseParsing

    var product: Product!

    required init(builder: RequestBuilding, executor: RequestExecuting, parser: ResponseParsing) {
        self.builder = builder
        self.executor = executor
        self.parser = parser
    }

    convenience init(product: Product, builder: RequestBuilding, executor: RequestExecuting, parser: ResponseParsing) {
        self.init(builder: builder, executor: executor, parser: parser)
        self.product = product
    }

    func execute(completion: @escaping (Product) -> (Void)) {
        let request = builder.make(for: .product(.details(product)))

        executor.execute(request, onCompletion: { response in
            do {
                completion(try self.parser.parseProductDetails(from: response))
            }
            catch ResponseParsingError.api(let code, let message) {
                NSLog("Api Error: \(code) - \(message)")
            }
            catch {
                NSLog("Parsing error: \(error.localizedDescription)")
            }
        }, onError: { error in
            print("Erorr while fetching product list:\(error.localizedDescription)")
        })
    }

    func objcExecute(completion: @escaping (Any) -> (Void)) {
        execute(completion: completion)
    }
}
