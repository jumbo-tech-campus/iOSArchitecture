import UIKit

extension UIView {
    class func fromNib<T: UIView>(owner: Any? = nil) -> T {
        guard let rootNib = Bundle.main.loadNibNamed(String(describing: T.self), owner: owner, options: nil)?.first, let view = rootNib as? T else {
            fatalError("Could not instantiate view from Nib")
        }

        return view
    }

    func setCornerRadius(_ value: CGFloat) {
        layer.cornerRadius = value
    }
}
