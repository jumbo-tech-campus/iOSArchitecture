import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    func configure(with presentableCategory: CategoryViewModel.PresentableCategory) {
        titleLabel.text = presentableCategory.title
        backgroundColor = presentableCategory.cellBackgroundColor.uiColor()
    }
}
