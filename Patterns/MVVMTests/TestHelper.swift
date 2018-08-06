import Foundation
@testable import MVVM

struct TestHelper {
    static func generateDummyProducts() -> [Product] {
        return ProductsServiceSingleton.shared.getProducts()
    }

    static func generateDummyProductCategories() -> [ProductCategory] {
        return ProductsServiceSingleton.shared.getCategories()
    }
}
