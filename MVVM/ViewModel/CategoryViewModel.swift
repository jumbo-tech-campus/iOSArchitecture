import Foundation

class CategoryViewModel {
    struct RefinedCategory {
        let id: String
        let title: String
        let subCategoriesCount: String
        let imageUrl: String
    }
    private var categories = [Category]()
    var categoriesCount: Int {
        return categories.count
    }

    func refinedCategory(for index: Int) -> RefinedCategory {
        let category = categories[index]

        return RefinedCategory(id: category.id, title: category.title, subCategoriesCount: "\(category.subCategoriesCount)", imageUrl: category.imageUrl)
    }

    func refreshCategories(completion: () -> Void) {
        categories = ProductsServiceSingleton.shared.getAllCategories()
        completion()
    }
}

extension CategoryViewModel: CollectionViewConfigurable {
    var collectionCellRegisterInfo: [CellRegisterInfo] {
        let cellClass = RootCategoryCollectionViewCell.self
        return [(cellClass: cellClass, reuseId: String(describing: cellClass), isXib: true)]
    }
    var collectionBackGroundColor: ColorHex { return "F0F0F0" }
    var minimumLineSpacing: Double { return 5.0 }
    var minimumInterItemSpacing: Double { return 5.0 }
    var sectionTopInset: Double { return 5.0 }
    var sectionBottomInset: Double { return 5.0 }
    var sectionLeftInset: Double { return 5.0 }
    var sectionRightInset: Double { return 5.0 }
    var columnItemCount: Int { return Device.isPadLandscape ? 3 : Device.isiPadPortrait ? 2 : 2 }
    var itemAspectRatio: Double { return 1.0 }
}
