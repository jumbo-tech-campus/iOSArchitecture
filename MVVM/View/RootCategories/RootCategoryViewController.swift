import UIKit

class RootCategoryViewController: UIViewController {

    var categoryViewModel: CategoryViewModel!
    lazy var collectionView: UICollectionView = { [unowned self] in
        return UICollectionView(viewModel: categoryViewModel, frame: self.view.bounds, datasourceDelegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)

        categoryViewModel.refreshCategories { [unowned self] in
            self.collectionView.reloadData()
        }
    }
}

extension RootCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
extension RootCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryViewModel.categoriesCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RootCategoryCollectionViewCell.self), for: indexPath) as? RootCategoryCollectionViewCell else {
            return RootCategoryCollectionViewCell()
        }

        cell.configure(with: categoryViewModel.refinedCategory(for: indexPath.row))

        return cell
    }
}
