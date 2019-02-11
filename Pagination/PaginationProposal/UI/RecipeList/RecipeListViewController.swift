
import UIKit

class RecipeListViewController: UIViewController {
    @IBOutlet private weak var recipeListTableView: UITableView!

    let viewModel: RecipeListViewModel = RecipeListViewModel()
    var hasData = true


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    init() {
        super.init(nibName: String(describing: RecipeListViewController.self), bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureRecipeListTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadRecipes(onComplete: refreshViewModel,
                              onDataEnd: { [weak self] in self?.hasData = false })
    }

    func refreshViewModel() {
        recipeListTableView.reloadData()
    }

    private func configureRecipeListTableView() {
        self.recipeListTableView.register(UINib(nibName: RecipeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RecipeTableViewCell.identifier)
        recipeListTableView.dataSource = self
        recipeListTableView.delegate = self
    }
}

extension RecipeListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataLenght()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell  else {
            return UITableViewCell()
        }

        cell.configure(data: self.viewModel.displayableRecipe(at: indexPath.row))
        return cell
    }
}

extension RecipeListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 &&
            hasData {

            let pageSize = calculatePageSize(for: tableView, and: cell)

            viewModel.loadRecipes(pageSize: pageSize,
                                  onComplete: refreshViewModel,
                                  onDataEnd: { [weak self] in
                                    self?.hasData = false
                                    print(self?.viewModel.debugPrintRecipes() ?? "END!")
            })
        }
    }

    func calculatePageSize(for tableView: UITableView, and cell: UITableViewCell) -> Int {
        let estimatedHeight = RecipeTableViewCell.estimatedHeight
        let tableHeight = Double(tableView.frame.height)
        return Int(max(PagingData.defaultPageSize, (Int(tableHeight / estimatedHeight))))
    }
}
