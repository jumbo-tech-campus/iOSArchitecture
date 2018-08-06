//
//  ResponseParsing.swift
//  Networking
//
//  Created by Ruud Puts on 03/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

protocol ResponseParsing {
    func validateResponse(_ response: Response) throws -> Data

    func parseProducts(from response: Response) throws -> [Product]
    func parseProductDetails(from response: Response) throws -> Product
}

enum ResponseParsingError: Error, Hashable {
    case noData
    case api(code: String, message: String)
}
