import UIKit

class CategoriesViewController: UIViewController {

    var categoryViewModel: CategoryViewModel!
    lazy var collectionView: UICollectionView = { [unowned self] in
    return UICollectionView(viewModel: self.categoryViewModel, frame: self.view.bounds, datasource: self, delegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = categoryViewModel.screenTitle

        self.view.addSubview(collectionView)
        categoryViewModel.refreshCategories { [unowned self] in
            self.collectionView.reloadData()
        }
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categoryViewModel[indexPath.row]
        let subCategoryViewModel = CategoryViewModel(parentCategory: selectedCategory)
        let subCategoryVc = CategoriesViewController()
        subCategoryVc.categoryViewModel = subCategoryViewModel
        let productsVc = ProductsViewController()
        productsVc.productViewModel = ProductViewModel(productCategory: selectedCategory)
        let nextVc = categoryViewModel.parentCategory == nil ? subCategoryVc : productsVc

        navigationController?.pushViewController(nextVc, animated: true)
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryViewModel.categoriesCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self), for: indexPath) as? CategoryCollectionViewCell else {
            return CategoryCollectionViewCell()
        }

        let category = categoryViewModel[indexPath.row]

        cell.configure(with: categoryViewModel.refine(category))

        return cell
    }
}
