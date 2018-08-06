//
//  RequestGateway.swift
//  Networking
//
//  Created by Ruud Puts on 03/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import Foundation

protocol RequestGateway: ObjcRequestGateway {
    associatedtype ResultType
    
    var builder: RequestBuilding { get }
    var executor: RequestExecuting { get }
    var parser: ResponseParsing { get }

    init(builder: RequestBuilding, executor: RequestExecuting, parser: ResponseParsing)

    func execute(completion: @escaping (ResultType) -> (Void))
}

@objc
protocol ObjcRequestGateway {

    func objcExecute(completion: @escaping (Any) -> (Void))
}
