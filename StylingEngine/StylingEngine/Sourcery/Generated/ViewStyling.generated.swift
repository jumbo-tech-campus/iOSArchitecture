// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import UIKit

@objc enum JMBViewStyle: Int {
    case promotionLabel
    case headerLabel
    case backgroundView
    case promotionView
}

@objc
extension UIView {
    func styleAs(_ style: JMBViewStyle) {
        switch style {
        case .promotionLabel:
            self.style(as: .promotionLabel)
            break
        case .headerLabel:
            self.style(as: .headerLabel)
            break
        case .backgroundView:
            self.style(as: .backgroundView)
            break
        case .promotionView:
            self.style(as: .promotionView)
            break
        }
    }
}

