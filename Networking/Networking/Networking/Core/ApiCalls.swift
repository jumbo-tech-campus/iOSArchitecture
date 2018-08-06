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
