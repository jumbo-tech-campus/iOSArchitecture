import Quick
import Nimble

@testable import Networking

class ProductListRequestOperationSpec: QuickSpec {

    override func spec() {
        describe("ProductListRequestOperation") {
            var sut: ProductListRequestOperation!

            beforeEach {
                sut = ProductListRequestOperation()
            }

            afterEach {
                sut = nil
            }

            describe("configuration") {
                it("uses a cached request executor") {
                    expect(sut.executor).to(beAnInstanceOf(CacheRequestExecutor.self))
                }

                it("uses the product list parser") {
                    expect(sut.parser).to(beAnInstanceOf(ProductListRequestParser.self))
                }

                it("uses product list route") {
                    expect(sut.request.route) == ProductsRouter.list
                }
            }
        }
    }
}
