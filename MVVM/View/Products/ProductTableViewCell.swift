import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!

    func configure(with presentableProduct: ProductViewModel.PresentableProduct) {
        titleLabel.text = presentableProduct.title
        priceLabel.text = presentableProduct.price
        quantityLabel.text = presentableProduct.quantity
        infoLabel.attributedText = presentableProduct.info
        expirationLabel.text = presentableProduct.expirationDate
    }
}
