import Foundation

class ProductDetailsRequestOperation: NSObject, RequestOperationType {
    typealias Result = Product

    var executor = RequestExecutor()
    var parser = ProductDetailsRequestParser()
    var request: Request

    @objc
    init(product: Product) {
        self.request = Request(route: ProductsRouter.details(of: product))
    }
}
