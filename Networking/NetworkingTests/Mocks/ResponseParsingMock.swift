//
//  ResponseParsingMock.swift
//  NetworkingTests
//
//  Created by Ruud Puts on 06/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

@testable import Networking
import Foundation

class ResponseParsingMock: ResponseParsing {
    struct Stubs {
        var validateResponse: Data?
        var parseProducts: [Product]?
        var parseProductDetails: Product?
    }

    struct Captures {
        var validateResponse: Response?
        var parseProducts: Response?
        var parseProductDetails: Response?
    }

    var stubs = Stubs()
    var captures = Captures()

    // ResponseParsing
    func validateResponse(_ response: Response) throws -> Data {
        captures.validateResponse = response
        return stubs.validateResponse!
    }

    func parseProducts(from response: Response) throws -> [Product] {
        captures.parseProducts = response
        return stubs.parseProducts!
    }

    func parseProductDetails(from response: Response) throws -> Product {
        captures.parseProductDetails = response
        return stubs.parseProductDetails!
    }
}
