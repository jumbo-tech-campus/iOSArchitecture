import Foundation

class ProductListRequestParser: RequestParserType {
    func parse(response: Response) throws -> [Product] {
        guard let data = response.data else {
            throw RequestParserError.noData
        }

        let response = try JSONDecoder().decode(ProductListResponseData.self, from: data)
        return response.products.data
    }
}
