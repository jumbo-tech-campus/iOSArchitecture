import UIKit

enum Device {
    static let isPadLandscape = (UIApplication.shared.statusBarOrientation == .landscapeRight || UIApplication.shared.statusBarOrientation == .landscapeRight) && UIDevice.current.userInterfaceIdiom == .pad
    static let isiPadPortrait = UIApplication.shared.statusBarOrientation == .portrait && UIDevice.current.userInterfaceIdiom == .pad
    static let isiPhoneLandscape = (UIApplication.shared.statusBarOrientation == .landscapeRight || UIApplication.shared.statusBarOrientation == .landscapeRight) && UIDevice.current.userInterfaceIdiom == .phone
    static let isiPhonePortrait = UIApplication.shared.statusBarOrientation == .portrait && UIDevice.current.userInterfaceIdiom == .phone
}

typealias ColorHex = String
typealias CellRegisterInfo = (cellClass: AnyClass, reuseId: String, isXib: Bool)
