import Foundation

extension Data {
    init(fromJsonFile filename: String) {
        let bundle = Bundle(for: ProductListRequestParserSpec.self)
        let filePath = bundle.path(forResource: filename, ofType: "json")!

        try! self.init(contentsOf: URL(fileURLWithPath: filePath))
    }
}
