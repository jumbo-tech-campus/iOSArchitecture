//
//  Request.swift
//  NetworkModule
//
//  Created by Ruud Puts on 19/01/2019.
//  Copyright © 2019 MobileSorcery. All rights reserved.
//

import Foundation

public class Request {
    public static func get(url: String, _ completion: @escaping (String?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard error == nil else {
                return completion(nil)
            }

            guard let data = data, let body = String(data: data, encoding: .utf8) else {
                return completion(nil)
            }

            completion(body)
        }.resume()
    }
}
