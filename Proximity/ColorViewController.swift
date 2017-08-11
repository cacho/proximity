//
//  ColorViewController.swift
//  Proximity
//
//  Created by hugo on 8/11/17.
//  Copyright © 2017 hugo. All rights reserved.
//

import UIKit
import CoreBluetooth


class ColorViewController: UIViewController {
    
    @IBOutlet weak var signalLabel: UILabel!

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateSignal(strenght:Int) {
        print(strenght)
        self.signalLabel.text = "\(strenght)"
    }
}
