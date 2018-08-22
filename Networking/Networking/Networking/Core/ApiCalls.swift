//
//  ApiCalls.swift
//  Networking
//
//  Created by Ruud Puts on 02/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

enum ApiCall {
    case image(ImageCall)
    case product(ProductCall)
    case user(UserCall)

    enum ImageCall {
        case custom(url: String)
    }

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
        case .image(let imageCall):
            var imageCallHash: Int

            switch imageCall {
            case .custom(_): imageCallHash = 0
            }

            return Int("1\(imageCallHash)") ?? 1
        case .product(let productCall):
            var productCallHash: Int

            switch productCall {
            case .list: productCallHash = 0
            case .details(_): productCallHash = 1
            }

            return Int("2\(productCallHash)") ?? 2
        case .user(let userCall):
            var userCallHash: Int

            switch userCall {
            case .logout: userCallHash = 0
            }

            return Int("3\(userCallHash)") ?? 3
        }
    }

    static func == (lhs: ApiCall, rhs: ApiCall) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
