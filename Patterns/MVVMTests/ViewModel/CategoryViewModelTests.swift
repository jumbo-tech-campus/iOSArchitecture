import XCTest
@testable import MVVM

class CategoryViewModelTests: XCTestCase {

    var sut: CategoryViewModel!
    var category: ProductCategory!

    override func setUp() {
        super.setUp()
        sut = CategoryViewModel()
        category = ProductCategory(id: "0", title: "title", subCategoriesCount: 0, imageUrlString: "Url")
    }

    func test_ScreenTitle() {
        XCTAssertEqual(sut.screenTitle, "Category")

        sut = CategoryViewModel(parentCategory: category)

        XCTAssertEqual(sut.screenTitle, "title Sub")
    }

    func test_RefinesPresentableCategory_CorrectTitleBasedOnParentCategory() {
        let presentableCategory = sut.refine(category)

        XCTAssertEqual(presentableCategory.title, "title")

        sut = CategoryViewModel(parentCategory: category)

        let presentableCategoryWithParent = sut.refine(category)

        XCTAssertEqual(presentableCategoryWithParent.title, "Products 0")
    }

    func test_RefinesPresentableCategory() {
        let presentableCategory = sut.refine(category)

        XCTAssertEqual(presentableCategory.subCategoriesCount, "0")

        XCTAssertEqual(presentableCategory.cellBackgroundColor, "FFFFFF")

        XCTAssertEqual(presentableCategory.imageUrl, URL(string: "Url"))
    }

    func test_CollectionViewConfiguration_ExposesCorrectData() {
        let collectionView = UICollectionView(viewModel: sut, frame: UIScreen.main.bounds)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        XCTAssertEqual(layout.itemSize, CGSize(width: 180.0, height: 180.0))

        XCTAssertEqual(layout.minimumLineSpacing, 5.0)

        XCTAssertEqual(layout.minimumInteritemSpacing, 5.0)

        XCTAssertEqual(layout.sectionInset.top, 5.0)

        XCTAssertEqual(layout.sectionInset.bottom, 5.0)

        XCTAssertEqual(layout.sectionInset.left, 5.0)

        XCTAssertEqual(layout.sectionInset.right, 5.0)

        XCTAssertEqual(layout.scrollDirection, .vertical)
    }
}


