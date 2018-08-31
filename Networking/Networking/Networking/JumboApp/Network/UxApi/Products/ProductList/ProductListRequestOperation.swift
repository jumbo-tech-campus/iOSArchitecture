import Foundation

class ProductListRequestOperation: NSObject, RequestOperationType {
    typealias Result = [Product]

    var executor = CacheRequestExecutor()
    var parser = ProductListRequestParser()
    var request = Request(route: ProductsRouter.list)
}
