//
//  Module.swift
//  FeatureModule
//
//  Created by Ruud Puts on 19/01/2019.
//  Copyright © 2019 MobileSorcery. All rights reserved.
//

import Foundation

public protocol Module: class {
    static var name: String { get }
    static var bundle: Bundle { get }
}

extension Bundle {
    static func `for`(module: Module.Type) -> Bundle {
        let bundle = Bundle(for: module)

        guard bundle != .main else {
            return bundle
        }

        let bundleName = "\(module.name).bundle"
        guard !bundle.bundlePath.hasSuffix(bundleName) else {
            return bundle
        }

        return Bundle(url: bundle.bundleURL.appendingPathComponent(bundleName))!
    }
}
