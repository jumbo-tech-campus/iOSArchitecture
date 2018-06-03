import UIKit

extension UITableView {
    convenience init<DD: UITableViewDelegate & UITableViewDataSource>(viewModel: TableViewConfigurable, frame: CGRect, style: UITableViewStyle = .plain, datasourceDelegate: DD) {
        self.init(frame: frame, style: style)

        viewModel.tableCellRegisterInfo.forEach {
            if $0.isXib {
                register(UINib(nibName: String(describing: $0.cellClass), bundle: nil), forCellReuseIdentifier: $0.reuseId)
            } else {
                register($0.cellClass, forCellReuseIdentifier: $0.reuseId)
            }
        }

        rowHeight = viewModel.rowHeight.cg()
        backgroundColor = UIColor.from(viewModel.tableBackGroundColor)
        contentInset = UIEdgeInsets(top: viewModel.sectionTopTableInset.cg(), left: viewModel.sectionLeftTableInset.cg(), bottom: viewModel.sectionBottomTableInset.cg(), right: viewModel.sectionRightTableInset.cg())
        delegate = datasourceDelegate
        dataSource = datasourceDelegate
    }
}
