//
//  Product.swift
//  Networking
//
//  Created by Ruud Puts on 03/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

@objc
class Product: NSObject, Codable {
    @objc var identifier: String
    @objc var title: String

    enum CodingKeys : String, CodingKey {
        case identifier = "id"
        case title
    }

    @objc init(identifier: String, title: String) {
        self.identifier = identifier
        self.title = title
    }
}
