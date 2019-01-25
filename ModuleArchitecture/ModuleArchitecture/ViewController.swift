//
//  ViewController.swift
//  ModuleArchitecture
//
//  Created by Ruud Puts on 19/01/2019.
//  Copyright © 2019 MobileSorcery. All rights reserved.
//

import UIKit
import UIModule
import NetworkModule
import FeatureModule

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UIModule.test()
        NetworkModule.test()

        view.style(as: .testView)

        Request.get(url: "https://api.ipify.org?format=json") {
            NSLog("Response: \($0 ?? "-")")
        }
    }

    @IBAction func doTheThing(_ sender: Any) {
        guard let viewController = FeatureModule.start() else {
            NSLog("FeatureModule didn't start")
            return
        }

        present(viewController, animated: true)
    }
}

extension ViewStyling where ViewType == UIView {
    static var testView = ViewStyling {
        $0.backgroundColor = UIColor.blue
    }
}

