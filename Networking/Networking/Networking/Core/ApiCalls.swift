//
//  ApiCalls.swift
//  Networking
//
//  Created by Ruud Puts on 02/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

enum ApiCall {
    case product(ProductCall)
    case user(UserCall)

    enum ProductCall {
        case list
        case details(Product)
    }

    enum UserCall {
        case logout
    }
}

extension ApiCall: Hashable {
    var hashValue: Int {
        switch self {
        case .product(let productCall):
            var productCallHash: Int

            switch productCall {
            case .list: productCallHash = 0
            case .details(_): productCallHash = 1
            }

            return Int("1\(productCallHash)") ?? 1
        case .user(let userCall):
            var userCallHash: Int

            switch userCall {
            case .logout: userCallHash = 0
            }

            return Int("1\(userCallHash)") ?? 1
        }
    }

    static func == (lhs: ApiCall, rhs: ApiCall) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
