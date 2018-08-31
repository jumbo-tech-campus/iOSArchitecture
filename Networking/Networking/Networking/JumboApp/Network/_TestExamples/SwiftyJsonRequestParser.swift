import Foundation
import SwiftyJSON

class SwiftyJsonRequestParser: RequestParserType {
    func parse(response: Response) throws -> [Product] {
        let jsonData = try validate(response: response)

        return jsonData["products"]["data"].array?.map { productJson in
            return parseProduct(from: productJson)
        } ?? []
    }

    private func parseProduct(from json: JSON) -> Product {
        // Note that currently product only has 2 properties, JMBProduct has 21
        // This code would duplicate when writing JSON
        return Product(identifier: json["id"].stringValue,
                       title: json["title"].stringValue)
    }

    func validate(response: Response) throws -> JSON {
        guard let data = response.data else {
            throw RequestParserError.noData
        }

        do {
            let jsonData = try JSON(data: data)
            if let errorCode = jsonData["code"].string, let errorMessage = jsonData["message"].string {
                throw RequestParserError.api(code: errorCode, message: errorMessage)
            }

            return jsonData
        } catch {
            throw RequestParserError.invalidData
        }
    }
}
