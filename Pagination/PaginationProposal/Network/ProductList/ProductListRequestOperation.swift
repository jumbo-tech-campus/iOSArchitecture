import JNetworkingKit

typealias ProductListRequestParser = AnyRequestParser<ProductsRawResponse>

final class ProductListRequestOperation: NSObject, RequestOperationType {
    typealias Result = ProductsRawResponse

    var executor = RequestExecutor()
    var parser = ProductListRequestParser()
    var request: Request

    init(searchTerm: String?, paging: (offset: Int, pageSize: Int)) {
        let route = Router.productList(searchTerm: searchTerm, paging: paging)
        request = Request(route: route)
    }
}
