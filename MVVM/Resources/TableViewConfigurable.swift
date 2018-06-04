import Foundation

protocol TableViewConfigurable {
    var tableCellRegisterInfo: [CellRegisterInfo] { get }
    var tableBackgroundColor: ColorHex { get }
    var rowHeight: Double { get }
    var sectionTopTableInset: Double { get }
    var sectionLeftTableInset: Double { get }
    var sectionBottomTableInset: Double { get }
    var sectionRightTableInset: Double { get }
    var allEqualTableInset: Double { get }
    var isStylePlain: Bool { get }
}

extension TableViewConfigurable {
    var tableBackgroundColor: ColorHex { return "FFFFFF" }
    var rowHeight: Double { return 44 }
    var sectionTopTableInset: Double { return 0.0 }
    var sectionLeftTableInset: Double { return 0.0 }
    var sectionBottomTableInset: Double { return 0.0 }
    var sectionRightTableInset: Double { return 0.0 }
    var allEqualTableInset: Double { return 0.0 }
    var isStylePlain: Bool { return true }
}
