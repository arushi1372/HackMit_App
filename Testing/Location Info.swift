//
//  Location Info.swift
//  Testing
//
//  Created by Lin Lin Lee on 9/19/20.
//

import Foundation
import CoreLocation
import SwiftUI

struct LocationManager {
    let locationManager = CLLocationManager()
    var totalCarTime = [Double]();
}

func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[locations.count - 1]
    if location.horizontalAccuracy > 0 {
        let speed = location.speed
        if 7.0 < speed && speed < 44.7 {
            totalCarTime.append(speed)
        }
        else {
            totalCarTime.append(3.0)
            print(totalCarTime)
        }
    }
}

func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
}
