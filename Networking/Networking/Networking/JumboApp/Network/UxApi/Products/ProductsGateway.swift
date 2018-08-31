import Foundation

@objc
protocol ProductsGateway {
    @objc func getProducts(onSuccess: @escaping ([Product]) -> Void, onError: @escaping (Error) -> Void)
    @objc func getProductDetails(_ product: Product, onSuccess: @escaping (Product) -> Void, onError: @escaping (Error) -> Void)
}

extension UxApiGateway: ProductsGateway {
    @objc func getProducts(onSuccess: @escaping ([Product]) -> Void, onError: @escaping (Error) -> Void) {
        ProductListRequestOperation().execute(onSuccess: onSuccess, onError: onError)
    }

    @objc func getProductDetails(_ product: Product, onSuccess: @escaping (Product) -> Void, onError: @escaping (Error) -> Void) {
        ProductDetailsRequestOperation(product: product).execute(onSuccess: onSuccess, onError: onError)
    }
}
