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
    var authorizationToken: String? { get set }

    func makeProductListGateway() -> ProductListGateway
    func makeProductDetailsGateway(for product: Product) -> ProductDetailsGateway

    func makeDownloadImageGateway(from url: String) -> DownloadImageGateway
}

@objc
class RequestGatewayFactory: NSObject, RequestGatewayProducing {
    var authorizationToken: String?
    lazy var apiConfiguration = UxAPI(endpoint: "https://mobileapi.jumbo.com", apiVersion: "V3")

    func makeProductListGateway() -> ProductListGateway {
        return ProductListGateway(builder: makeRequestBuilder(),
                                  executor: RequestExecutor(),
                                  parser: UxApiResponseParser())
    }

    func makeProductDetailsGateway(for product: Product) -> ProductDetailsGateway {
        return ProductDetailsGateway(product: product,
                                     builder: makeRequestBuilder(),
                                     executor: RequestExecutor(),
                                     parser: UxApiResponseParser())
    }

    func makeDownloadImageGateway(from url: String) -> DownloadImageGateway {
        return DownloadImageGateway(imageUrl: url,
                                    builder: makeRequestBuilder(),
                                    executor: RequestExecutor(),
                                    parser: UxApiResponseParser())
    }
}

private extension RequestGatewayFactory {
    func makeRequestBuilder() -> RequestBuilding {
        return UxApiRequestBuilder(configuration: apiConfiguration,
                                   authorizationToken: authorizationToken)
    }
}
