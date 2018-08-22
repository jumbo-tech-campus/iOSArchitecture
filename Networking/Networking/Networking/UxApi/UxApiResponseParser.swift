//
//  UxApiResponseParser.swift
//  Networking
//
//  Created by Ruud Puts on 03/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import UIKit

class UxApiResponseParser: ResponseParsing {
    func parseProducts(from response: Response) throws -> [Product] {
        let data = try validateResponse(response)

        let response = try JSONDecoder().decode(ProductListResponseData.self, from: data)

        return response.products.data
    }

    func parseProductDetails(from response: Response) throws -> Product {
        let data = try validateResponse(response)

        let response = try JSONDecoder().decode(ProductDetailsResponseData.self, from: data)

        return response.product.data
    }

    func parseImage(from response: Response) throws -> UIImage {
        let data = try validateResponse(response)

        guard let image = UIImage(data: data) else {
            throw ResponseParsingError.invalidData
        }

        return image
    }

    func validateResponse(_ response: Response) throws -> Data {
        guard let data = response.data else {
            throw ResponseParsingError.noData
        }

        if let error = try? JSONDecoder().decode(UxApiError.self, from: data) {
            throw ResponseParsingError.api(code: error.code, message: error.message)
        }

        return data
    }
}

struct ProductListResponseData: Codable {
    let products: PaginatedResponseData<Product>
    let filters: ResponseData<[ProductFilter]>
}

struct ProductDetailsResponseData: Codable {
    let product: ResponseData<Product>
}

struct UxApiError: Codable {
    let code: String
    let message: String
}
