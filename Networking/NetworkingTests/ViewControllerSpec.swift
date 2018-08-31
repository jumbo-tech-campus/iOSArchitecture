import Quick
import Nimble

@testable import Networking

class ViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ViewController") {
            var sut: ViewController!
            var gatewayMock: ProductsGatewayMock!

            beforeEach {
                sut = ViewController()
                gatewayMock = ProductsGatewayMock()

                sut.gateway = gatewayMock
            }

            afterEach {
                sut = nil
            }

            context("getting products list") {
                beforeEach {
                    sut.executeGetProducts()
                }

                it("executes the get products") {
                    expect(gatewayMock.captures.getProducts).toNot(beNil())
                }
            }

            context("getting product details") {
                beforeEach {
                    sut.executeGetProductDetails()
                }

                it("executes the get product details") {
                    expect(gatewayMock.captures.getProductDetails).toNot(beNil())
                }
            }
        }
    }
}
