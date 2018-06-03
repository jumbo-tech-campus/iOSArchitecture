import UIKit

class ProductViewModel {
    struct PresentableProduct {
        let title: String
        let info: NSAttributedString
        let price: String
        let expirationDate: String
        let quantity: String
        let imageUrl: URL
        let productCategory: String
    }
    private var products = [Product]()
    private var productCategory: ProductCategory!
    var productsCount: Int {
        return products.count
    }
    let screenTitle = "Products"

    init(productCategory: ProductCategory) {
        self.productCategory = productCategory
    }

    subscript (index: Int) -> Product {
        return products[index]
    }

    func refreshProducts(completion: () -> Void) {
        products = ProductsServiceSingleton.shared.getProducts(categoryId: productCategory.id)

        completion()
    }

    func refine(_ product: Product) -> PresentableProduct {
        let expiration = expirationDateString(from: product.expirationTimestamp)
        let price = productPrice(from: product.price)
        let attributes = [NSAttributedStringKey: String]()

        return PresentableProduct(title: product.title, info: NSAttributedString.init(string: product.info, attributes: attributes), price: price, expirationDate: expiration, quantity: "\(product.quantity) pieces", imageUrl: URL(string: product.imageUrlString)!, productCategory: productCategory.title)
    }

    private func expirationDateString(from timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium

        return  "Expires: \(dateFormatter.string(from: date))"
    }

    private func productPrice(from rawValue: Double) -> String {
        let price = rawValue as NSNumber

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "nl_NL")

        return formatter.string(from: price) ?? ""
    }
}

extension ProductViewModel: TableViewConfigurable {
    var tableCellRegisterInfo: [CellRegisterInfo] {
        let cellClass = ProductTableViewCell.self
        return [(cellClass: cellClass, reuseId: String(describing: cellClass), isXib: true)]
    }
    var rowHeight: Double { return 100.0 }
    var allEqualTableInset: Double { return 10.0 }
}
