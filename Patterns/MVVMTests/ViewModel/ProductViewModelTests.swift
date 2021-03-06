import XCTest
@testable import MVVM

class ProductViewModelTests: XCTestCase {

    var sut: ProductViewModel!

    override func setUp() {
        super.setUp()
        sut = ProductViewModel(productCategory: ProductCategory(id: "", title: "category", subCategoriesCount: 0, imageUrlString: "Url"))
        sut.productsObservable.value = TestHelper.generateDummyProducts()
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func test_RefinesPresentableProduct() {
        let product = Product(id: "0", title: "title", info: "info", price: 33.0, expirationTimestamp: 1528061030, quantity: 5, imageUrlString: "https://httpbin.org/image", rootCategoryId: 5)
        let presentableProduct = sut.refine(product)

        XCTAssertEqual(presentableProduct.title, "title")

        XCTAssertEqual(presentableProduct.info, NSAttributedString(string: "info"))

        XCTAssertEqual(presentableProduct.price, "€ 33,00")

        XCTAssertEqual(presentableProduct.expirationDate, "Expires: Jun 3, 2018 at 11:23:50 PM")

        XCTAssertEqual(presentableProduct.quantity, "5 pieces")

        XCTAssertEqual(presentableProduct.imageUrl, URL(string: product.imageUrlString))

        XCTAssertEqual(presentableProduct.productCategory, "category")

        XCTAssertEqual(presentableProduct.imageUrl, URL(string: "https://httpbin.org/image"))
    }

    func test_TableViewConfiguration_ExposesCorrectData() {
        let tableView = UITableView(viewModel: sut, frame: UIScreen.main.bounds)

        XCTAssertEqual(tableView.rowHeight, 100.0)

        XCTAssertEqual(tableView.style, .plain)
    }
}
