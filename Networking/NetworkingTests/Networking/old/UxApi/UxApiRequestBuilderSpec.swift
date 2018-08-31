//
//  UxApiRequestBuilderSpec.swift
//  NetworkingTests
//
//  Created by Ruud Puts on 06/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

@testable import Networking
import Quick
import Nimble

class UxApiRequestBuilderSpec: QuickSpec {
    override func spec() {
        describe("UxApiRequestBuilder") {
            var sut: UxApiRequestBuilder!
            var result: RequestSpecification?

            var apiConfiguration: ApiConfiguringMock!

            beforeEach {
                apiConfiguration = ApiConfiguringMock()
                apiConfiguration.host = "http://unit-tests"

                sut = UxApiRequestBuilder(configuration: apiConfiguration)
            }

            afterEach {
                result = nil
                sut = nil
                apiConfiguration = nil
            }

            context("product calls") {
                context("build product list call") {
                    beforeEach {
                        result = sut.specification(for: .product(.list))
                    }

                    it("builds the specification") {
                        expect(result) == RequestSpecification(host: apiConfiguration.host,
                                                               path: "products")
                    }
                }

                context("build product details call") {
                    var product: Product!

                    beforeEach {
                        product = Product(identifier: "test_product", title: "Test Product")
                        result = sut.specification(for: .product(.details(product)))
                    }

                    afterEach {
                        product = nil
                    }

                    it("builds the specification") {
                        expect(result) == RequestSpecification(host: apiConfiguration.host,
                                                               path: "products/{id}",
                                                               parameters: ["id": product.identifier])
                    }
                }
            }

            context("user calls") {
                context("build logout call") {
                    beforeEach {
                        result = sut.specification(for: .user(.logout))
                    }

                    it("builds the specification") {
                        expect(result) == RequestSpecification(host: apiConfiguration.host,
                                                               path: "users/me/logout")
                    }
                }
            }
        }
    }
}
