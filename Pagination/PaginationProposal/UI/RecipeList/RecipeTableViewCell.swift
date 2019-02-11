import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeLabel: UILabel!
    public static let identifier = "RecipeTableViewCell"
    public static let estimatedHeight = 120.0

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
    }

    func configure(data: RecipeDataDisplayable) {
        recipeLabel.text = data.name
    }
}
