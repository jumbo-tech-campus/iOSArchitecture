/*
    - Create this protocol once and reuse it through the app of defining the UI
*/

import Foundation

protocol CollectionViewConfigurable {
    var collectionCellRegisterInfo: [CellRegisterInfo] { get }
    var collectionBackgroundColor: ColorHex { get }
    var isScrollDirectionVertical: Bool { get }
    var minimumLineSpacing: Double { get }
    var minimumInterItemSpacing: Double { get }
    var sectionTopInset: Double { get }
    var sectionLeftInset: Double { get }
    var sectionBottomInset: Double { get }
    var sectionRightInset: Double { get }
    var allEqualInset: Double { get }
    var rowItemCount: Int { get }
    var columnItemCount: Int { get }
    var itemAspectRatio: Double { get }
}

extension CollectionViewConfigurable {
    var collectionBackgroundColor: ColorHex { return "FFFFFF" }
    var isScrollDirectionVertical: Bool { return true }
    var minimumLineSpacing: Double { return 0.0 }
    var minimumInterItemSpacing: Double { return 0.0 }
    var sectionTopInset: Double { return 0.0 }
    var sectionLeftInset: Double { return 0.0 }
    var sectionBottomInset: Double { return 0.0 }
    var sectionRightInset: Double { return 0.0 }
    var allEqualInset: Double { return 0.0 }
    var rowItemCount: Int { return 0 }
    var columnItemCount: Int { return 0 }
    var itemAspectRatio: Double { return 0.0 }
}
