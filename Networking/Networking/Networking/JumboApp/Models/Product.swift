import Foundation

@objc
class Product: NSObject, Codable {
    @objc var identifier: String
    @objc var title: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
    }

    @objc init(identifier: String, title: String) {
        self.identifier = identifier
        self.title = title
    }
}
