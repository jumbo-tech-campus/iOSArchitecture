//
//  UxApiRequestBuilder.swift
//  Networking
//
//  Created by Ruud Puts on 03/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

class UxApiRequestBuilder: RequestBuilding {
    let apiConfiguration: ApiConfiguring

    init(configuration: ApiConfiguring) {
        apiConfiguration = configuration
    }


    func specification(for apiCall: ApiCall) -> RequestSpecification {
        switch apiCall {
        case .product(let productCall): return specification(for: productCall)
        case .user(let userCall): return specification(for: userCall)
        }
    }

    private func specification(for productCall: ApiCall.ProductCall) -> RequestSpecification {
        switch productCall {
        case .list:
            return RequestSpecification(host: apiConfiguration.host, path: "products")
        case .details(let product):
            return RequestSpecification(host: apiConfiguration.host,
                                        path: "products/{id}",
                                        parameters: ["id": product.identifier])
        }
    }

    private func specification(for userCall: ApiCall.UserCall) -> RequestSpecification {
        switch userCall {
        case .logout:
            return RequestSpecification(host: apiConfiguration.host, path: "users/me/logout")
        }
    }
}
