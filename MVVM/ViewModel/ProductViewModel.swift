import Foundation

class ProductViewModel {
    struct PresentableProduct {
        let id: Int
        let title: String
        let info: String
        let price: String
        let expirationDate: String
        let quantity: String
        let imageUrl: String
        let rootCategory: String
    }

    private var presentableProducts = [PresentableProduct]()

    var presentableProductsCount: Int {
        return presentableProducts.count
    }

    func presentableProduct(for index: Int) -> PresentableProduct {
        return presentableProducts[index]
    }
}
