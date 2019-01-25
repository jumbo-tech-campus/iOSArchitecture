//
//  ViewController.swift
//  FeatureModule
//
//  Created by Ruud Puts on 19/01/2019.
//  Copyright © 2019 MobileSorcery. All rights reserved.
//

import UIKit
import UIModule
import NetworkModule

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        UIModule.test()
        NetworkModule.test()

        view.style(as: .testView)

        Request.get(url: "https://api.ipify.org?format=json") {
            NSLog("Response: \($0 ?? "-")")
        }
        
        imageView.image = UIImage(named: "burger", in: FeatureModule.bundle, compatibleWith: nil)
    }

    @IBAction func doTheThing(_ sender: Any) {
    }
}

extension ViewStyling where ViewType == UIView {
    static var testView = ViewStyling {
        $0.backgroundColor = UIColor.purple
    }
}
