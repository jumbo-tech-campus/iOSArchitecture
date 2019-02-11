

import Foundation

struct ProductsRawResponse: Codable, RawResponseType {
    let products: Products
    let filters: Filters
}

struct Filters: Codable {
    let data: [FiltersDatum]
}

struct FiltersDatum: Codable {
    let type: TypeEnum
    let items: [Item]
    let title: String?
}

struct Item: Codable {
    let id, title: String
    let count: Int
    let isCategory: Bool
}

enum TypeEnum: String, Codable {
    case group = "group"
    case quickfilter = "quickfilter"
}

struct Products: Codable {
    let data: [ProductsDatum]
    let total, offset: Int
}

struct ProductsDatum: Codable {
    let id, title: String
    let quantityOptions: [QuantityOption]
    let prices: Prices
    let available: Bool
    let productType: ProductType
    let imageInfo: ImageInfo
    let topLevelCategory, topLevelCategoryID: String
    let quantity: String?
    let promotionBadgesToDisplay: PromotionBadgesToDisplay?

    enum CodingKeys: String, CodingKey {
        case id, title, quantityOptions, prices, available, productType, imageInfo, topLevelCategory
        case topLevelCategoryID = "topLevelCategoryId"
        case quantity, promotionBadgesToDisplay
    }
}

struct ImageInfo: Codable {
    let primaryView: [PrimaryView]
}

struct PrimaryView: Codable {
    let url: String
    let width, height: Int
}

struct Prices: Codable {
    let price: Price
    //let unitPrice: UnitPrice
}

struct Price: Codable {
    let currency: Currency
    let amount: Int
}

enum Currency: String, Codable {
    case eur = "EUR"
}

struct UnitPrice: Codable {
    let unit: UnitPriceUnit
    let price: Price
}

enum UnitPriceUnit: String, Codable {
    case kg = "kg"
    case piece = "piece"
}

enum ProductType: String, Codable {
    case partOfRetailSet = "PartOfRetailSet"
    case product = "Product"
    case retailSet = "RetailSet"
}

struct Promotion: Codable {
    let id: String
    let name: String?
    let parent: JSONNull?
    let type: String?
    let error: JSONNull?
    let label: String?
    let fromDate: Int?
    let toDate: Int?
    let summary, priceInformation: String?
    let maxApplications: Int?
    let badgeImage: BadgeImage?
}

struct BadgeImage: Codable {
    let main: String
}

struct PromotionBadgesToDisplay: Codable {
    let leftTop: LeftTop
}

struct LeftTop: Codable {
    let image: String
}

struct QuantityOption: Codable {
    let defaultAmount, minimumAmount, amountStep: Int
    let unit: QuantityOptionUnit
    let maximumAmount: Int
}

enum QuantityOptionUnit: String, Codable {
    case grams = "grams"
    case pieces = "pieces"
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
