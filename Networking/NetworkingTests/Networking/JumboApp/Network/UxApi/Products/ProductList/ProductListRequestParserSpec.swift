import Quick
import Nimble

@testable import Networking

class ProductListRequestParserSpec: QuickSpec {

    override func spec() {
        describe("ProductListRequestParser") {
            var response: Response!
            var sut: ProductListRequestParser!

            beforeEach {
                sut = ProductListRequestParser()
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

            context("parsing products") {
                var result: [Product]!

                beforeEach {
                    response = Response(data: Data(fromJsonFile: "uxapi_products"),
                                        statusCode: 200)

                    result = try! sut.parse(response: response)
                }

                afterEach {
                    result = nil
                }

                it("parses two products") {
                    expect(result.count) == 2
                }

                it("parses the id of the first product") {
                    expect(result.first?.identifier) == "129647STK"
                }

                it("parses the id of the second product") {
                    expect(result.last?.identifier) == "129649STK"
                }
            }
        }
    }
}
