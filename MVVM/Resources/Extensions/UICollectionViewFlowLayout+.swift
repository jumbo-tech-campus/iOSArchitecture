import UIKit

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
