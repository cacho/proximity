//
//  ParticlesViewController.swift
//  Proximity
//
//  Created by hugo on 8/16/17.
//  Copyright © 2017 hugo. All rights reserved.
//

import UIKit
import SpriteKit

class ParticlesViewController: UIViewController {

    @IBOutlet weak var skview: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateSignal(strength:Int) {
        print(strength)
    }
}
