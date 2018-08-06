/*
    - This is a common way to expose services to the app (not recommended, but easy)
    - See DependencyComposition target for a safer way with equal the amount of access
*/

import Foundation

final class ProductsServiceSingleton {
    private init() { }

    static let shared = ProductsServiceSingleton()

    var someStateAccessibleToEveryone: [String] = []

    func getCategories(parentId: String = "") -> [ProductCategory] {
        var categories = [ProductCategory]()

        let titleComponent = parentId == "" ? "Category" : "Sub"

        (0...20).forEach {
            categories.append(ProductCategory(id: "\($0)", title: "\(titleComponent) \($0)", subCategoriesCount: 5, imageUrlString: "https://httpbin.org/image"))
        }

        return categories
    }

    func getProducts(categoryId: String = "") -> [Product] {
        var products = [Product]()

        (0...50).forEach {
            products.append(Product(id: "\($0)", title: "Product \($0)", info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", price: Double(arc4random_uniform(50)), expirationTimestamp: 1528053197, quantity: Int(arc4random_uniform(10)), imageUrlString: "https://httpbin.org/image", rootCategoryId: $0))
        }

        return products
    }
}
