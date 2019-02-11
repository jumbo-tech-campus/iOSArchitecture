struct ProductDataDisplayable: Codable {
    let name: String

    init(from product: ProductsDatum) {
        self.name = product.title
    }
}
