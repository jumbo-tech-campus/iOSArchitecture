import Foundation

class ProductDetailsRequestParser: RequestParserType {
    func parse(response: Response) throws -> Product {
        guard let data = response.data else {
            throw RequestParserError.noData
        }

        let response = try JSONDecoder().decode(ProductDetailsResponseData.self, from: data)
        return response.product.data
    }
}
