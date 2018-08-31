import Quick
import Nimble

@testable import Networking

class ProductDetailsRequestParserSpec: QuickSpec {

    override func spec() {
        describe("ProductListRequestParser") {
            var response: Response!
            var sut: ProductDetailsRequestParser!

            beforeEach {
                sut = ProductDetailsRequestParser()
            }

            afterEach {
                sut = nil
            }

            context("response validation") {
                context("no data") {
                    var capturedError: RequestParserError!

                    beforeEach {
                        response = Response(data: nil, statusCode: 0)

                        do { _ = try sut.parse(response: response) }
                        catch { capturedError = error as! RequestParserError }
                    }

                    afterEach {
                        capturedError = nil
                    }

                    it("throws the no data error") {
                        expect(capturedError) == RequestParserError.noData
                    }
                }
            }

            context("parsing product details") {
                var result: Product!

                beforeEach {
                    response = Response(data: Data(fromJsonFile: "uxapi_productdetails"),
                                        statusCode: 200)

                    result = try! sut.parse(response: response)
                }

                afterEach {
                    result = nil
                }

                it("parses the product id") {
                    expect(result.identifier) == "129647STK"
                }

                it("parses the product title") {
                    expect(result.title) == "Jumbo Komkommer"
                }
            }
        }
    }
}
