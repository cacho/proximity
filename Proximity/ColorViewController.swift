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
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var signalLabel: UILabel!
    var timer: Timer?

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateSignal(strength:Int) {
        print(strength)
        self.signalLabel.text = "\(strength)"

        let max = -55.0
        let min = -80.0
        let maxP = max + min * -1
        let normalized = Double(strength) + min * -1
        var red = normalized / maxP
        if red > 1.0 {
            red = 1.0
        } else if red < 0.0 {
            red = 0.0
        }
        self.colorView.backgroundColor = UIColor(red: CGFloat(red), green: 0.0, blue: 0.0, alpha: 1.0)
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            print("off!")
            self.colorView.backgroundColor = UIColor.black
            self.signalLabel.text = "---"
        }
    }

}
