import Foundation

protocol ProductListGateway {
    func productList(searchTerm: String?,
                    paging: (offset: Int, pageSize: Int),
                    onSuccess: @escaping (ProductsRawResponse) -> Void,
                    onError: @escaping (Error) -> Void)

}

extension Gateway: ProductListGateway {
    func productList(searchTerm: String?,
                    paging: (offset: Int, pageSize: Int),
                    onSuccess: @escaping (ProductsRawResponse) -> Void,
                    onError: @escaping (Error) -> Void) {
        print("Requesting more: \(paging)")
        ProductListRequestOperation(searchTerm: searchTerm, paging: paging).execute(onSuccess: onSuccess, onError: onError)
    }
}
