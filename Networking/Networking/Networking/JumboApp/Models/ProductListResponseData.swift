import Foundation

struct ProductListResponseData: Codable {
    let products: PaginatedResponseData<Product>
    let filters: ResponseData<[ProductFilter]>
}

struct ProductDetailsResponseData: Codable {
    let product: ResponseData<Product>
}
