//
//  ApiConfiguringMock.swift
//  NetworkingTests
//
//  Created by Ruud Puts on 06/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

@testable import Networking

class ApiConfiguringMock: ApiConfiguring {
    struct Stubs {
        var host = ""
    }

    struct Captures {
        var host: String?
    }

    var stubs = Stubs()
    var captures = Captures()

    // ApiConfiguring

    var host: String {
        get { return stubs.host }
        set { captures.host = newValue }
    }
}

