//
//  Speed.swift
//  Testing
//
//  Created by Arushi on 9/19/20.
//

import Foundation
import CoreLocation
import Combine
import UIKit

class LocationManager: NSObject, ObservableObject {

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    @Published var locationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
        }
    }

    @Published var lastLocation: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var allLocation: [CLLocation]? {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var allSpeeds: [CGFloat]? {
        willSet {
            objectWillChange.send()
        }
    }

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }

    }

    let objectWillChange = PassthroughSubject<Void, Never>()

    private let locationManager = CLLocationManager()
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        print(#function, statusString)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        self.allLocation = locations
        var speeds: [CGFloat] = []
        for index in 0..<locations.count{
            var speed = locations[index].speed
            speed = speed * (2.23694/3600) * (411) //convert meters per second to mile //convert to grams of CO2 emitted
            speeds.append(CGFloat(speed))
        }
        
        let chunkSize = 60
        let chunks = stride(from: 0, to: speeds.count, by: chunkSize).map {
            Array(speeds[$0..<min($0 + chunkSize, speeds.count)])
        }
        let summed = chunks.map { $0.reduce(0, {$0 + $1})}
        self.allSpeeds = summed
//        print(#function, allSpeeds)
        print(#function, location)
    }
}
