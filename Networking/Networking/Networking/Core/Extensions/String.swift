//
//  String.swift
//  Networking
//
//  Created by Ruud Puts on 02/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

internal extension String {
    func inject(parameters: [String: Any]?) -> String {
        var result = self

        // swiftlint:disable force_try
        try! NSRegularExpression(pattern: "\\{(\\w{1,})\\}")
            .matches(in: result, range: NSRange(location: 0, length: result.count))
            .reversed().forEach { match in
                let fullRange = Range(match.range, in: result)!
                let fullMatch = String(result[fullRange])

                let keyRange = Range(match.range(at: 1), in: result)!
                let key = String(result[keyRange])

                if let value = parameters?[key] {
                    result = result.replacingOccurrences(of: fullMatch, with: "\(value)")
                }
                else {
                    print("No value passed for '\(key)' parameter")
                }
        }

        return result
    }
}
