//
//  DownloadImageGateway.swift
//  Networking
//
//  Created by Ruud Puts on 03/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import UIKit

@objc
class DownloadImageGateway: NSObject, RequestGateway {
    var builder: RequestBuilding
    var executor: RequestExecuting
    var parser: ResponseParsing

    var imageUrl: String!

    required init(builder: RequestBuilding, executor: RequestExecuting, parser: ResponseParsing) {
        self.builder = builder
        self.executor = executor
        self.parser = parser
    }

    convenience init(imageUrl: String, builder: RequestBuilding, executor: RequestExecuting, parser: ResponseParsing) {
        self.init(builder: builder, executor: executor, parser: parser)
        self.imageUrl = imageUrl
    }

    func execute(completion: @escaping (UIImage) -> (Void)) {
        let request = builder.make(for: .image(.custom(url: imageUrl)))

        executor.execute(request, onCompletion: { response in
            do {
                completion(try self.parser.parseImage(from: response))
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
