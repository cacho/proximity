//
//  AppDelegate.swift
//  Proximity
//
//  Created by hugo on 8/11/17.
//  Copyright © 2017 hugo. All rights reserved.
//

import UIKit
import CoreBluetooth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CBCentralManagerDelegate, CBPeripheralManagerDelegate {

    var window: UIWindow?
    var central: CBCentralManager?
    var peripheral: CBPeripheralManager?
    var controller: ParticlesViewController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.controller = ParticlesViewController(nibName: "ParticlesViewController", bundle: nil)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.controller
        self.window?.makeKeyAndVisible()
        self.central = CBCentralManager(delegate: self, queue: nil)
        self.peripheral = CBPeripheralManager(delegate: self, queue: nil)
        return true
    }

    /**
    Central manager protocol
    */

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            central.scanForPeripherals(withServices: [CBUUID.init(string: "180D")], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
        }
    }


    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if RSSI.intValue < 0 {
            self.controller?.updateSignal(strength: RSSI.intValue)
        }
    }


    /**
    Peripheral manager protocol
    */

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == CBManagerState.poweredOn {
            let serviceUUID = CBUUID.init(string: "180D")
            let pipeUUID = CBUUID.init(string: "281D")
            let characteristic = CBMutableCharacteristic(type: pipeUUID, properties: CBCharacteristicProperties.notify, value: nil, permissions: CBAttributePermissions.init(rawValue: 0))
            let service = CBMutableService(type: serviceUUID, primary: true)
            service.characteristics = [characteristic]
            peripheral.add(service)
            peripheral.startAdvertising([CBAdvertisementDataServiceUUIDsKey : [serviceUUID]])
        }
    }

}

