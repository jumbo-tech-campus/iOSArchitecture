
import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var productListTableView: UITableView!

    let viewModel: ProductListViewModel = ProductListViewModel()
    var hasData = true


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    init() {
        super.init(nibName: String(describing: ProductListViewController.self), bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureProductListTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadProducts(onComplete: refreshViewModel,
                              onDataEnd: { [weak self] in self?.hasData = false })
    }

    func refreshViewModel() {
        productListTableView.reloadData()
    }

    private func configureProductListTableView() {
        self.productListTableView.register(UINib(nibName: ProductTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.identifier)
        productListTableView.dataSource = self
        productListTableView.delegate = self
    }
}

extension ProductListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataLenght()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell  else {
            return UITableViewCell()
        }

        cell.configure(data: self.viewModel.displayableProduct(at: indexPath.row))
        return cell
    }
}

extension ProductListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 &&
            hasData {

            let pageSize = calculatePageSize(for: tableView, and: cell)

            viewModel.loadProducts(pageSize: pageSize,
                                  onComplete: refreshViewModel,
                                  onDataEnd: { [weak self] in
                                    self?.hasData = false
            })
        }
    }

    func calculatePageSize(for tableView: UITableView, and cell: UITableViewCell) -> Int {
        let estimatedHeight = ProductTableViewCell.estimatedHeight
        let tableHeight = Double(tableView.frame.height)
        return Int(max(PagingData.defaultPageSize, (Int(tableHeight / estimatedHeight))))
    }
}
