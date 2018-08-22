//
//  UxApiRequestBuilder.swift
//  Networking
//
//  Created by Ruud Puts on 03/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

class UxApiRequestBuilder: RequestBuilding {
    let apiConfiguration: ApiConfiguring
    let authorizationToken: String?

    init(configuration: ApiConfiguring, authorizationToken: String? = nil) {
        apiConfiguration = configuration
        self.authorizationToken = authorizationToken
    }

    func specification(for apiCall: ApiCall) -> RequestSpecification {
        switch apiCall {
        case .image(let imageCall): return specification(for: imageCall)
        case .product(let productCall): return specification(for: productCall)
        case .user(let userCall): return specification(for: userCall)
        }
    }
}

private extension UxApiRequestBuilder {
    var defaultHeaders: [String: String] {
        guard let token = authorizationToken else {
            return [:]
        }

        return ["X-Jumbo-Token": token]
    }

    func specification(for imageCall: ApiCall.ImageCall) -> RequestSpecification {
        switch imageCall {
        case .custom(let urlString):
            guard let url = URL(string: urlString) else {
                fatalError("Invalid url passed!")
            }

            return RequestSpecification(host: "\(url.scheme!)://\(url.host!)",
                                        path: url.path,
                                        headers: defaultHeaders)
        }
    }

    func specification(for productCall: ApiCall.ProductCall) -> RequestSpecification {
        switch productCall {
        case .list:
            return RequestSpecification(host: apiConfiguration.host,
                                        path: "products",
                                        headers: defaultHeaders)
        case .details(let product):
            return RequestSpecification(host: apiConfiguration.host,
                                        path: "products/{id}",
                                        parameters: ["id": product.identifier],
                                        headers: defaultHeaders)
        }
    }

    func specification(for userCall: ApiCall.UserCall) -> RequestSpecification {
        switch userCall {
        case .logout:
            return RequestSpecification(host: apiConfiguration.host,
                                        path: "users/me/logout",
                                        headers: defaultHeaders)
        }
    }
}
