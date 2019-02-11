import Foundation

class ProductListRepository: PagingRepositoryType {

    var pagingData: PagingData = PagingData()

    init() {
    }

    func getProducts(searchTerm: String?,
                    pageSize: Int = PagingData.defaultPageSize,
                    onSuccess: @escaping ([ProductsDatum]) -> Void,
                    onError: @escaping (Error) -> Void,
                    onDataEnd: @escaping () -> Void) {

        DispatchQueue.global(qos: .background).async {
            Gateway().productList(searchTerm: searchTerm,
                                 paging: self.nextPage(pageSize: pageSize),
                                 onSuccess: { [weak self] (productsDatum) in
                                    self?.extractData(pageable: ProductsPageable(from: productsDatum),
                                                      onSuccess: onSuccess,
                                                      onDataEnd: onDataEnd) },
                                 onError: onError)

        }
    }

}
