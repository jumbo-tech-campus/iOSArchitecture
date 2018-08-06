//
//  UxAPIResponseParser_SwiftyJson.swift
//  Networking
//
//  Created by Ruud Puts on 03/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

class UxAPIResponseParser_SwiftyJson: ResponseParsing {
    func parseProducts(from response: Response) throws -> [Product] {
        let data = try validateResponse(response)

        let jsonData = try json(from: data)

        return jsonData["products"]["data"].array?.map { productJson in
            return parseProduct(from: productJson)
        } ?? []
    }

    func parseProductDetails(from response: Response) throws -> Product {
        let data = try validateResponse(response)

        let jsonData = try json(from: data)

        return parseProduct(from: jsonData["product"]["data"])
    }

    func validateResponse(_ response: Response) throws -> Data {
        guard let data = response.data else {
            throw ResponseParsingError.noData
        }

        if let json = try? json(from: data),
            let errorCode = json["code"].string,
            let errorMessage = json["message"].string {
            throw ResponseParsingError.api(code: errorCode, message: errorMessage)
        }

        return data
    }
}

private extension UxAPIResponseParser_SwiftyJson {
    func json(from data: Data) throws -> JSON {
        return try JSON(data: data)
    }

    private func parseProduct(from json: JSON) -> Product {
        // Note that currently product only has 2 properties, JMBProduct has 21
        // This code would duplicate when writing JSON
        return Product(identifier: json["id"].stringValue,
                       title: json["title"].stringValue)
    }

}
