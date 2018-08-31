import Quick
import Nimble

@testable import Networking

class ProductDetailsRequestOperationSpec: QuickSpec {

    override func spec() {
        describe("ProductDetailsRequestOperation") {
            var sut: ProductDetailsRequestOperation!
            var product: Product!

            beforeEach {
                product = Product(identifier: "1", title: "Fake product")
                sut = ProductDetailsRequestOperation(product: product)
            }

            afterEach {
                sut = nil
                product = nil
            }

            describe("configuration") {
                it("uses a cached request executor") {
                    expect(sut.executor).to(beAnInstanceOf(RequestExecutor.self))
                }

                it("uses the product Details parser") {
                    expect(sut.parser).to(beAnInstanceOf(ProductDetailsRequestParser.self))
                }

                it("uses product details route") {
                    expect(sut.request.route) == ProductsRouter.details(of: product)
                }
            }
        }
    }
}
