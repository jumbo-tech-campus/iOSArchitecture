import Foundation

class ProductListViewModel {
    let repository: ProductListRepository
    lazy private var products: [ProductsDatum] = [ProductsDatum]()

    init(repository: ProductListRepository = ProductListRepository()) {
        self.repository = repository
    }

    func loadProducts(searchTerm: String? = nil,
                     pageSize: Int = PagingData.defaultPageSize,
                     onComplete: @escaping () -> Void,
                     onDataEnd: @escaping () -> Void) {
        self.repository.getProducts(searchTerm: searchTerm,
                                   pageSize: pageSize,
                                   onSuccess:{ [weak self] (products) in
                                    self?.refreshProductsData(newProducts: products, onComplete: onComplete) },
                                   onError:{ (error) in
                                    print(error)
        }, onDataEnd: onDataEnd)
    }

    func refreshProductsData(newProducts: [ProductsDatum], onComplete: @escaping () -> Void) {
        products.append(contentsOf: newProducts)
        onComplete()
    }

    func displayableProduct(at index: Int) -> ProductDataDisplayable {
        return ProductDataDisplayable(from: products[index])
    }

    func dataLenght() -> Int {
        return products.count
    }
}
