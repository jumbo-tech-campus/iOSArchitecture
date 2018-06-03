import Foundation

class CategoryViewModel {
    struct PresentableCategory {
        let id: String
        let title: String
        let subCategoriesCount: String
        let imageUrl: URL
        let cellBackgroundColor: ColorHex
    }
    private var productCategories = [ProductCategory]()
    let parentCategory: ProductCategory?
    var categoriesCount: Int { return productCategories.count }
    var screenTitle: String {
        if let parentCategory = parentCategory {
            return "\(parentCategory.title) Sub"
        } else {
            return "Category"
        }
    }

    init(parentCategory: ProductCategory? = nil) {
        self.parentCategory = parentCategory
    }

    subscript (index: Int) -> ProductCategory {
        return productCategories[index]
    }

    func refine(_ category: ProductCategory) -> PresentableCategory {
        let title = parentCategory == nil ? category.title : "Products \(category.id)"

        return PresentableCategory(id: category.id, title: title, subCategoriesCount: "\(category.subCategoriesCount)", imageUrl: URL(string: category.imageUrlString)!, cellBackgroundColor: "FFFFFF")
    }

    func refreshCategories(completion: () -> Void) {
        productCategories = ProductsServiceSingleton.shared.getCategories()
        completion()
    }
}

extension CategoryViewModel: CollectionViewConfigurable {
    var collectionCellRegisterInfo: [CellRegisterInfo] {
        let cellClass = CategoryCollectionViewCell.self
        return [(cellClass: cellClass, reuseId: String(describing: cellClass), isXib: true)]
    }
    var collectionBackgroundColor: ColorHex { return "F0F0F0" }
    var minimumLineSpacing: Double { return 5.0 }
    var minimumInterItemSpacing: Double { return 5.0 }
    var sectionTopInset: Double { return 5.0 }
    var sectionBottomInset: Double { return 5.0 }
    var sectionLeftInset: Double { return 5.0 }
    var sectionRightInset: Double { return 5.0 }
    var itemAspectRatio: Double { return 1.0 }
    var columnItemCount: Int {
        let iPhoneColumnCount = parentCategory == nil ? 2 : 3
        return Device.isPadLandscape ? 3 : Device.isiPadPortrait ? 2 : iPhoneColumnCount
    }
}
