
import UIKit

class ProductsViewController: UIViewController {

    var productViewModel: ProductViewModel!
    lazy var tableView: UITableView = { [unowned self] in
        return UITableView(viewModel: self.productViewModel, frame: self.view.bounds, style: .plain, datasource: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = productViewModel.screenTitle

        self.view.addSubview(tableView)

        productViewModel.productsObservable.observe { [unowned self] products in
            self.tableView.reloadData()
            self.navigationItem.prompt = "\(products.count) products"
        }

        productViewModel.refreshProducts()
    }
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModel.productsObservable.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductTableViewCell.self), for: indexPath) as? ProductTableViewCell else {
            return ProductTableViewCell()
        }

        let product = productViewModel.productsObservable.value[indexPath.row]

        cell.configure(with: productViewModel.refine(product))

        return cell
    }
}
