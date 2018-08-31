//
//  RequestExecutorSpec.swift
//  NetworkingTests
//
//  Created by Ruud Puts on 06/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

@testable import Networking
import Quick
import Nimble

class RequestExecutorSpec: QuickSpec {
    override func spec() {
        describe("RequestExecutor") {
            var sut: RequestExecutor!
            var request: Request!
            var requestClient: RequestClientMock!

            var onCompleteCapture: Response?
            var onErrorCapture: Error?

            beforeEach {
                requestClient = RequestClientMock()
                sut = RequestExecutor(requestClient: requestClient)
            }

            afterEach {
                sut = nil
                request = nil
                requestClient = nil
            }

            context("succesfull client execution") {
                var response: Response!

                beforeEach {
                    request = Request(url: "https://google.com", method: .get, data: nil)

                    response = Response(data: nil, statusCode: 418)
                    requestClient.stubs.response = response

                    sut.execute(request, onCompletion: {
                        onCompleteCapture = $0
                    }, onError: {
                        onErrorCapture = $0
                    })
                }

                afterEach {
                    response = nil
                }

                it("sends the response to onComplete") {
                    expect(onCompleteCapture) === response
                }
            }

            context("failed client execution") {
                var error: RequestClientError!

                beforeEach {
                    request = Request(url: "https://google.com", method: .get, data: nil)

                    error = RequestClientError.invalidRequest
                    requestClient.stubs.error = error

                    sut.execute(request, onCompletion: {
                        onCompleteCapture = $0
                    }, onError: {
                        onErrorCapture = $0
                    })
                }

                afterEach {
                    error = nil
                }

                it("calls onError with the error") {
                    expect(onErrorCapture as? RequestClientError) == error
                }
            }
        }
    }
}

