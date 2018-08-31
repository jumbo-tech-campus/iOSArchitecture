import Quick
import Nimble

@testable import Networking

class EnvironmentSpec: QuickSpec {

    override func spec() {
        describe("Environment") {
            let serverStub = "http://www.jumbo.com"
            let pathStub = "backend"
            let versionStub: String? = nil
            var sut: Environment!

            beforeEach {
                sut = Environment(server: serverStub, path: pathStub, version: versionStub)
            }

            it("return the correct url") {
                expect(sut.url).to(equal("http://www.jumbo.com/backend"))
            }
        }
    }
}
