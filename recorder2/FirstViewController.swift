//
//  FirstViewController.swift
//  recorder2
//
//  Created by yoshiokaas on 2015/09/20.
//  Copyright © 2015年 tachibanakikaku.com. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, ESTBeaconManagerDelegate {
    
    let beaconManager = ESTBeaconManager()

    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
        identifier: "aegif region"
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion)
    }
    
    let placesByBeacons = [
        "6342:23998": [
            "Mint Cocktail": 10,
            "Green & Green Salads": 150,
            "Mini Panini": 325
        ]
    ]
    
    func placesNearBeacon(beacon: CLBeacon) -> [String] {
        let beaconKey = "\(beacon.major):\(beacon.minor)"
        if let places = self.placesByBeacons[beaconKey] {
            let sortedPlaces = Array(places).sort() { $0.1 < $1.1 }.map { $0.0 }
            return sortedPlaces
        }
        return []
    }
    
    func beaconManager(manager: AnyObject!, didRangeBeacons beacons: [AnyObject]!,
        inRegion region: CLBeaconRegion!) {
            if let nearestBeacon = beacons.first as? CLBeacon {
                let places = placesNearBeacon(nearestBeacon)
                print(places) // TODO: remove after implementing the UI
            }
    }

}

