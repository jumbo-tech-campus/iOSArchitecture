import UIKit

class RootCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    func configure(with refinedCategory: CategoryViewModel.RefinedCategory) {
        titleLabel.text = refinedCategory.title
        backgroundColor = .white
    }
}
