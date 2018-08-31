//
//  ProductDetailsGateway.swift
//  NetworkingTests
//
//  Created by Ruud Puts on 07/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

@testable import Networking
import Quick
import Nimble

class ProductDetailsGatewaySpec: QuickSpec {
    // swiftlint:disable function_body_length
    override func spec() {
        describe("ProductDetailsGateway") {
            var sut: ProductDetailsGateway!
            var product: Product!

            var request: Request!
            var response: Response!
            var requestBuilder: RequestBuildingMock!
            var responseParser: ResponseParsingMock!
            var requestExecutor: RequestExecutingMock!

            beforeEach {
                request = Request(url: "http://myapi/show/identifier",
                                  method: .get, data: nil)
                requestBuilder = RequestBuildingMock()
                requestBuilder.stubs.make = request

                response = Response(data: nil, statusCode: 200)

                requestExecutor = RequestExecutingMock()
                requestExecutor.stubs.response = response

                product = Product(identifier: "1", title: "Product1")
                responseParser = ResponseParsingMock()
                responseParser.stubs.parseProductDetails = product

                sut = ProductDetailsGateway(product: product,
                                            builder: requestBuilder,
                                            executor: requestExecutor,
                                            parser: responseParser)
            }

            afterEach {
                sut = nil

                responseParser = nil
                requestExecutor = nil
                requestBuilder = nil
                product = nil
                response = nil
                request = nil
            }

            context("gateway execution") {
                var result: Product!

                beforeEach {
                    sut.execute() {
                        result = $0
                    }
                }

                afterEach {
                    result = nil
                }

                it("builds the request") {
                    expect(requestBuilder.captures.make) == ApiCall.product(.details(product))
                }

                it("executes the request") {
                    expect(requestExecutor.captures.execute?.request) === request
                }

                it("parses the response") {
                    expect(responseParser.captures.parseProductDetails) === response
                }

                it("passes the parsed data into the completion handler") {
                    expect(result) == product
                }
            }
        }
    }
}

