import UIKit

// Used by Sourcery to generate ObjC boilerplace
// Note: There shouldn't be a need to access the stylesheet directly from Objective-C,
//       So the boilerplate generation might be removed
protocol ObjcFloat {}
protocol ObjcColor {}
protocol ObjcFont {}

struct Stylesheet {
    struct Dimensions: ObjcFloat {
        static let smallSpacing = CGFloat(8)
        static let mediumSpacing = CGFloat(16)
        static let largeSpacing = CGFloat(32)
    }

    struct Colors: ObjcColor {
        static let red = UIColor.red
        static let blue = UIColor.blue
        static let green = UIColor.green
    }

    struct Fonts: ObjcFont {
        static let header = UIFont.boldSystemFont(ofSize: 20)
        static let content = UIFont.systemFont(ofSize: 14)
    }
}
