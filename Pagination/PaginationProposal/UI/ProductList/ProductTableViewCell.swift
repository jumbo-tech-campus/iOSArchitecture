import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productLabel: UILabel!
    public static let identifier = "ProductTableViewCell"
    public static let estimatedHeight = 120.0

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
    }

    func configure(data: ProductDataDisplayable) {
        productLabel.text = data.name
    }
}
