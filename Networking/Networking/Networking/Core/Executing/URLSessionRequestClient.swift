//
//  URLSessionRequestClient.swift
//  Networking
//
//  Created by Ruud Puts on 02/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

extension URLSession: RequestClient {
    // The reason 
    func execute(_ request: Request, completion: @escaping (Response?, RequestClientError?) -> Void) {
        guard let request = request.asUrlRequest() else {
            return completion(nil, RequestClientError.invalidRequest)
        }

        dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return completion(nil, RequestClientError.generic(message: error!.localizedDescription))
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(nil, RequestClientError.invalidResponse)
            }

            guard let data = data else {
                return completion(nil, RequestClientError.noData)
            }

            let response = Response(data: data, statusCode: httpResponse.statusCode)
            completion(response, nil)
        }.resume()
    }
}

extension Request {
    func asUrlRequest() -> URLRequest? {
        guard let url = URL(string: self.url) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue

        return request
    }
}
