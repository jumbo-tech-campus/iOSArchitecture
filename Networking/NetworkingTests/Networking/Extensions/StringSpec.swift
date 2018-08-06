//
//  StringSpec.swift
//  NetworkingTests
//
//  Created by Ruud Puts on 06/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

@testable import Networking
import Quick
import Nimble

class StringSpec: QuickSpec {
    override func spec() {
        describe("String") {
            var sut: String!

            context("injecting paramters") {
                var result: String!

                beforeEach {
                    sut = "{param1}-{param2}"
                }

                afterEach {
                    sut = nil
                }

                context("matching parameters") {
                    beforeEach {
                        let parameters = ["param1": "test", "param2": "parameters"]
                        result = sut.inject(parameters: parameters)
                    }

                    afterEach {
                        result = nil
                    }

                    it("returns string with paramters injected") {
                        expect(result) == "test-parameters"
                    }
                }

                context("missing parameter") {
                    beforeEach {
                        result = sut.inject(parameters: ["param2": "parameters"])
                    }

                    afterEach {
                        result = nil
                    }

                    it("returns string with possible arguments injected") {
                        expect(result) == "{param1}-parameters"
                    }
                }
            }
        }
    }
}
