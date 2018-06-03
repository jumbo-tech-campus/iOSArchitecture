import Foundation

final class ProductsServiceSingleton {
    private init() { }

    static let shared = ProductsServiceSingleton()

    var someStateAccessibleToEveryone: [String] = []

    func getAllCategories() -> [Category] {
        var categories = [Category]()

        (0...10).forEach { categories.append(Category(id: "\($0)", title: "C \($0)", subCategoriesCount: 5, imageUrl: "domain.com/\($0)")) }

        return categories
    }
}
