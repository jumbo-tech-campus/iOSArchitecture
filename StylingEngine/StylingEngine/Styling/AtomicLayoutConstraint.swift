//
//  AtomicLayoutConstraint.swift
//  StylingEngine
//
//  Created by Ruud Puts on 17/07/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import UIKit

/**
 Below is an example how a custom NSLayoutConstraint with an option to set a spacing from the StyleSheet directly from interface builder.
 Unfortunately IB can't render (i.e. an enum as) a custom dropdown so for now a textfield is used.
 In IB itself the field can contain either 'small', 'medium' or 'large', the constant will be determined by the code below.

 Usefulness is still under discussion; As i.e. small spacing on a screen edge might still be different then a small spacing between views
 */

@IBDesignable
class AtomicLayoutConstraint: NSLayoutConstraint {

    @IBInspectable var spacingName: String? {
        didSet {
            spacing = Spacing.from(spacingName)
        }
    }
    var spacing: Spacing? = nil

    enum Spacing {
        case small
        case medium
        case large

        var value: CGFloat {
            switch self {
            case .small: return Stylesheet.Dimensions.smallSpacing
            case .medium: return Stylesheet.Dimensions.mediumSpacing
            case .large: return Stylesheet.Dimensions.largeSpacing
            }
        }

        static func from(_ string: String?) -> Spacing? {
            guard let string = string?.lowercased() else {
                return nil
            }

            switch string[string.startIndex] {
            case "s": return .small
            case "m": return .medium
            case "l": return .large
            default:
                return nil
            }
        }
    }

    override var constant: CGFloat {
        get {
            guard let spacing = spacing else {
                return super.constant
            }

            return spacing.value
        }
        set {
            if spacing == nil {
                super.constant = newValue
            }
        }
    }
}
