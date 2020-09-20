//
//  SpeedView.swift
//  Testing
//
//  Created by Arushi on 9/19/20.
//
#if DEBUG
import SwiftUI

struct MovementView: View {
    @ObservedObject var locationManager = LocationManager()

    var userSpeed: String {
        return "\(locationManager.lastLocation?.speed ?? 0)"
    }

    var body: some View {
        VStack {
            Text("location status: \(locationManager.statusString)")
            HStack {
                Text("Speed: \(userSpeed)")
                .navigationBarTitle(Text("Movement Footprint"))
            }
        }
    }
}

struct MovementView_Previews: PreviewProvider {
    static var previews: some View {
        MovementView()
    }
}
#endif
