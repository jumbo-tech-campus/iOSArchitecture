import Foundation
import JNetworkingKit

extension Environment {
    static var active: Environment = production

    static let secret = Environment(server: "secret-url-replace",
                                     version: "v1")

    static let production = Environment(server: "https://mobileapi.jumbo.com",
                                     version: "v4")

}

extension Request {
    init(route: RequestRoute? = nil,
         method: Request.Method = .get,
         headers: RequestHeaders = [:],
         parameters: RequestParameters = [:],
         data: Data? = nil) {
        self.init(environment: Environment.active,
                  route: route,
                  method: method,
                  headers: headers,
                  parameters: parameters,
                  data: data)
    }
}
