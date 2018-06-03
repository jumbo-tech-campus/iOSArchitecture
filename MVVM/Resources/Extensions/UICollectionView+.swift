import UIKit

extension UICollectionView {
    convenience init<DD: UICollectionViewDelegate & UICollectionViewDataSource>(viewModel: CollectionViewConfigurable, frame: CGRect, datasourceDelegate: DD) {
        self.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout(viewModel: viewModel, frame: frame))

        viewModel.collectionCellRegisterInfo.forEach {
            if $0.isXib {
                register(UINib(nibName: String(describing: $0.cellClass), bundle: nil), forCellWithReuseIdentifier: $0.reuseId)
            } else {
                register($0.cellClass, forCellWithReuseIdentifier: $0.reuseId)
            }
        }

        backgroundColor = UIColor.from(viewModel.collectionBackGroundColor)
        delegate = datasourceDelegate
        dataSource = datasourceDelegate
    }
}
