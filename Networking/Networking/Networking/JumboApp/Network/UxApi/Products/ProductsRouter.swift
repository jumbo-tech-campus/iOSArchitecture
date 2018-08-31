import Foundation

struct ProductsRouter {
    static let list = RequestRoute(path: "products/")

    static func details(of product: Product) -> RequestRoute {
        return RequestRoute(path: "products/{id}", parameters: ["id": product.identifier])
    }
}
