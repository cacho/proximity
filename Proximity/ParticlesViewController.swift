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
    var scene: SKScene?
    var emitter: SKEmitterNode?
    var offTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupScene()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scene?.size = self.skview.bounds.size
        self.emitter?.position = self.skview.center
    }

    func setupScene() {
        self.scene = SKScene(size: self.skview.bounds.size)
        self.scene?.scaleMode = SKSceneScaleMode.aspectFill
        self.scene?.backgroundColor = UIColor.black
        self.skview.presentScene(self.scene)

        self.emitter = SKEmitterNode()
        self.emitter?.particleTexture = SKTexture(imageNamed: "particle1.png")
        self.emitter?.particleBlendMode = SKBlendMode.add
        self.emitter?.particleColorSequence = SKKeyframeSequence(keyframeValues: [
            UIColor.orange,
            UIColor.white,
            UIColor.orange
        ], times: [0, 0.6, 1])
        self.emitter?.particleColorBlendFactor = 1
        self.emitter?.particleColorRedRange = 100
        self.emitter?.particleColorRedRange = 1
        self.emitter?.particlePositionRange = CGVector(dx: 0, dy: 240)
        self.emitter?.particleBirthRate = 0
        self.emitter?.particleLifetime = 2
        self.emitter?.particleLifetimeRange = 1
        self.emitter?.particleSpeed = 60
        self.emitter?.particleSpeedRange = 50
        self.emitter?.particleAlphaSequence = SKKeyframeSequence(keyframeValues: [1, 0.9, 0], times: [0, 0.8, 1])
        self.emitter?.emissionAngle = 0
        self.emitter?.emissionAngleRange = CGFloat.pi * 2
        self.emitter?.particleScaleSequence = SKKeyframeSequence(keyframeValues: [0, 3.6, 0], times: [0, 0.08, 1])
        self.scene?.addChild(self.emitter!)
    }

    func updateSignal(strength:Int) {
        print(strength)
        let max = -55.0
        let min = -80.0
        let maxP = max + min * -1
        let normalized = Double(strength) + min * -1
        var scaled = normalized / maxP
        if scaled > 1.0 {
            scaled = 1.0
        } else if scaled < 0.0 {
            scaled = 0.0
        }
        self.emitter?.particleBirthRate = CGFloat(60 * scaled)

        self.offTimer?.invalidate()
        self.offTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            self.emitter?.particleBirthRate = 0
        }
    }
}
