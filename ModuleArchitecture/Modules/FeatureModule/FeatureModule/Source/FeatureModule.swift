//
//  FeatureModule.swift
//  FeatureModule
//
//  Created by Ruud Puts on 19/01/2019.
//  Copyright © 2019 MobileSorcery. All rights reserved.
//

import Foundation
import UIKit

public class FeatureModule {
    public static func start() -> UIViewController? {
        return UIStoryboard(name: "Main", bundle: bundle).instantiateInitialViewController()
    }
}

extension FeatureModule: Module {
    public static var name: String {
        return String(describing: self)
    }

    public static var bundle: Bundle {
        return Bundle.for(module: self.self)
    }
}
