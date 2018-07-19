//
//  View.swift
//  StylingEngine
//
//  Created by Ruud Puts on 17/07/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

import UIKit

extension ViewStyling where ViewType == UIView {
    static var backgroundView = ViewStyling {
        $0.backgroundColor = Stylesheet.Colors.green
    }

    static var promotionView = ViewStyling {
        $0.backgroundColor = Stylesheet.Colors.blue
        $0.layer.cornerRadius = 10
    }
}
