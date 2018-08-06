//
//  RequestGatewayFactory.swift
//  Networking
//
//  Created by Ruud Puts on 03/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

@objc
protocol RequestGatewayProducing {
    func makeProductListGateway() -> ProductListGateway
    func makeProductDetailsGateway(for product: Product) -> ProductDetailsGateway
}

@objc
class RequestGatewayFactory: NSObject, RequestGatewayProducing {
    lazy var apiConfiguration = UxAPI(endpoint: "https://mobileapi.jumbo.com", apiVersion: "V3")

    func makeProductListGateway() -> ProductListGateway {
        return ProductListGateway(builder: UxApiRequestBuilder(configuration: apiConfiguration),
                                  executor: RequestExecutor(),
                                  parser: UxApiResponseParser())
    }

    func makeProductDetailsGateway(for product: Product) -> ProductDetailsGateway {
        return ProductDetailsGateway(product: product,
                                     builder: UxApiRequestBuilder(configuration: apiConfiguration),
                                     executor: RequestExecutor(),
                                     parser: UxApiResponseParser())
    }
}
