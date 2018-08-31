import Foundation

@testable import Networking

class ProductsGatewayMock {
    var captures = Captures()

    struct Captures {
        var getProducts: GetProducts?
        var getProductDetails: GetProductDetails?

        struct GetProducts {
            let onSuccess: ([Product]) -> Void
            let onError: (Error) -> Void
        }

        struct GetProductDetails {
            let product: Product
            let onSuccess: (Product) -> Void
            let onError: (Error) -> Void
        }
    }
}

extension ProductsGatewayMock: ProductsGateway {
    func getProducts(onSuccess: @escaping ([Product]) -> Void, onError: @escaping (Error) -> Void) {
        captures.getProducts = Captures.GetProducts(onSuccess: onSuccess, onError: onError)
    }

    func getProductDetails(_ product: Product, onSuccess: @escaping (Product) -> Void, onError: @escaping (Error) -> Void) {
        captures.getProductDetails = Captures.GetProductDetails(product: product, onSuccess: onSuccess, onError: onError)
    }
}
