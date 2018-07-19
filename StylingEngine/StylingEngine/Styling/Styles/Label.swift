//
//  Label.swift
//  StylingEngine
//
//  Created by Ruud Puts on 17/07/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import UIKit

extension ViewStyling where ViewType == UILabel {
    static var promotionLabel = ViewStyling {
        $0.style(as: .promotionView)
        $0.font = Stylesheet.Fonts.content
        $0.textColor = Stylesheet.Colors.red

        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }

    static var headerLabel = ViewStyling {
        $0.font = Stylesheet.Fonts.header
        $0.textColor = Stylesheet.Colors.blue
    }
}
