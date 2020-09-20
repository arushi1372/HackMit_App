//
//  Info Sheet.swift
//  Testing
//
//  Created by Lin Lin Lee on 9/19/20.
//

import Foundation
import SwiftUI

struct InfoSheet : Identifiable {
    var id = UUID()
    var name: String
    var footprint: Double
//    var wifi: Double
//    var wwan: Double
    
    var imageName: String { return name }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

#if DEBUG
let testData = [
    InfoSheet(name: "Today", footprint: 30.5),
    InfoSheet(name: "Yesterday", footprint: 20.5),
    InfoSheet(name: "This Week", footprint: 51.0),
    InfoSheet(name: "This Month", footprint: 1200.0),
    InfoSheet(name: "This Year", footprint: 2300.0),
]
#endif
