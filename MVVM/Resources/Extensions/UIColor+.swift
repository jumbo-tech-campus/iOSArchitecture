import UIKit

extension UIColor {
    class func from(_ hex: ColorHex) -> UIColor {
        var trimmed = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        guard trimmed.count == 6 else {
            return .white
        }

        if trimmed.hasPrefix("#") {
            trimmed.remove(at: trimmed.startIndex)
        }

        var rgbValue: UInt32 = 0

        Scanner(string: trimmed).scanHexInt32(&rgbValue)

        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                       alpha: 1.0)
    }
}
