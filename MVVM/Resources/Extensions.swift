import UIKit

extension UIView {
    class func fromNib<T: UIView>(owner: Any? = nil) -> T {
        guard let rootNib = Bundle.main.loadNibNamed(String(describing: T.self), owner: owner, options: nil)?.first, let view = rootNib as? T else {
            fatalError("Could not instantiate view from Nib")
        }
        return view
    }

    func setCornerRadius(_ value: CGFloat) {
        layer.cornerRadius = value
    }
}

extension UITableView {
    convenience init(viewModel: TableViewConfigurable, frame: CGRect, datasource: UITableViewDataSource? = nil, delegate: UITableViewDelegate? = nil) {
        self.init(frame: frame, style: viewModel.isStylePlain ? .plain : .grouped)

        viewModel.tableCellRegisterInfo.forEach {
            if $0.isXib {
                register(UINib(nibName: String(describing: $0.cellClass), bundle: nil), forCellReuseIdentifier: $0.reuseId)
            } else {
                register($0.cellClass, forCellReuseIdentifier: $0.reuseId)
            }
        }

        rowHeight = viewModel.rowHeight.cg()
        backgroundColor = viewModel.tableBackgroundColor.uiColor()
        contentInset = UIEdgeInsets(top: viewModel.sectionTopTableInset.cg(), left: viewModel.sectionLeftTableInset.cg(), bottom: viewModel.sectionBottomTableInset.cg(), right: viewModel.sectionRightTableInset.cg())
        self.delegate = delegate
        self.dataSource = datasource
    }
}

extension UICollectionView {
    convenience init(viewModel: CollectionViewConfigurable, frame: CGRect, datasource: UICollectionViewDataSource? = nil, delegate: UICollectionViewDelegate? = nil) {
        self.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout(viewModel: viewModel, frame: frame))

        viewModel.collectionCellRegisterInfo.forEach {
            if $0.isXib {
                register(UINib(nibName: String(describing: $0.cellClass), bundle: nil), forCellWithReuseIdentifier: $0.reuseId)
            } else {
                register($0.cellClass, forCellWithReuseIdentifier: $0.reuseId)
            }
        }

        backgroundColor = viewModel.collectionBackgroundColor.uiColor()
        self.dataSource = datasource
        self.delegate = delegate
    }
}

extension UICollectionViewFlowLayout {
    convenience init(viewModel: CollectionViewConfigurable, frame: CGRect) {
        self.init()
        let lineSpacing = viewModel.minimumLineSpacing.cg()
        let interItemSpacing = viewModel.minimumInterItemSpacing.cg()
        let topInset = viewModel.sectionTopInset.cg()
        let leftInset = viewModel.sectionLeftInset.cg()
        let bottomInset = viewModel.sectionBottomInset.cg()
        let rightInset = viewModel.sectionRightInset.cg()
        let allEqualInset = viewModel.allEqualInset.cg()
        let rows = CGFloat(viewModel.rowItemCount)
        let collumns = CGFloat(viewModel.columnItemCount)
        let aspectRatio = viewModel.itemAspectRatio.cg()
        let widthSpacing = allEqualInset == 0.0 ? leftInset + rightInset + (interItemSpacing * (collumns - 1)) : allEqualInset * (collumns + 1)
        let heightSpacing = allEqualInset == 0.0 ? topInset + bottomInset + (lineSpacing * (rows - 1)) : allEqualInset * (rows + 1)
        let itemWidth = (frame.width - widthSpacing) / collumns

        if aspectRatio == 0.0 {
            let itemHeight = (frame.height - heightSpacing) / rows
            itemSize = CGSize(width: itemWidth, height: itemHeight)
        } else {
            itemSize = CGSize(width: itemWidth, height: (itemWidth * aspectRatio))
        }

        scrollDirection = viewModel.isScrollDirectionVertical ? .vertical : .horizontal
        sectionInset = allEqualInset == 0.0 ? UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset) : UIEdgeInsetsMake(allEqualInset, allEqualInset, allEqualInset, allEqualInset)
        minimumInteritemSpacing = allEqualInset == 0.0 ? interItemSpacing : allEqualInset
        minimumLineSpacing = allEqualInset == 0.0 ? lineSpacing : allEqualInset
    }
}

extension Double {
    func cg() -> CGFloat {
        return CGFloat(self)
    }
}

extension ColorHex {
    func uiColor() -> UIColor {
        var trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        guard trimmed.count == 6 else {
            return .white
        }

        if trimmed.hasPrefix("#") {
            trimmed.remove(at: trimmed.startIndex)
        }

        var rgbValue: UInt32 = 0

        Scanner(string: trimmed).scanHexInt32(&rgbValue)

        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                       alpha: 1.0)
    }
}
