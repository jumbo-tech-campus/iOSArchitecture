//
//  UxApiResponseParserSpec.swift
//  NetworkingTests
//
//  Created by Ruud Puts on 06/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

@testable import Networking
import Quick
import Nimble

class UxApiResponseParserSpec: QuickSpec {
    override func spec() {
        describe("UxApiResponseParser") {
            var sut: UxApiResponseParser!

            var response: Response!

            beforeEach {
                sut = UxApiResponseParser()
            }

            afterEach {
                response = nil
                sut = nil
            }

            context("response validation") {
                context("no data") {
                    var capturedError: ResponseParsingError!

                    beforeEach {
                        response = Response(data: nil, statusCode: 0)

                        do { _ = try sut.validateResponse(response) }
                        catch { capturedError = error as! ResponseParsingError }
                    }

                    afterEach {
                        capturedError = nil
                    }

                    it("throws the no data error") {
                        expect(capturedError) == ResponseParsingError.noData
                    }
                }

                context("error from api") {
                    var capturedError: ResponseParsingError!

                    beforeEach {
                        response = Response(data: Data(fromJsonFile: "uxapi_error"),
                                            statusCode: 200)

                        do { _ = try sut.validateResponse(response) }
                        catch { capturedError = error as! ResponseParsingError }
                    }

                    afterEach {
                        capturedError = nil
                    }

                    it("throws the api error") {
                        expect(capturedError) == ResponseParsingError.api(code: "4036",
                                                                          message: "Lookup Not Found")
                    }
                }
            }

            context("parsing products") {
                var result: [Product]!

                beforeEach {
                    response = Response(data: Data(fromJsonFile: "uxapi_products"),
                                        statusCode: 200)

                    result = try! sut.parseProducts(from: response)
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

            context("parsing product details") {
                var result: Product!

                beforeEach {
                    response = Response(data: Data(fromJsonFile: "uxapi_productdetails"),
                                        statusCode: 200)

                    result = try! sut.parseProductDetails(from: response)
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

extension Data {
    init(fromJsonFile filename: String) {
        let bundle = Bundle(for: UxApiResponseParserSpec.self)
        let filePath = bundle.path(forResource: filename, ofType: "json")!

        // swiftlint:disable force_try
        try! self.init(contentsOf: URL(fileURLWithPath: filePath))
    }
}

