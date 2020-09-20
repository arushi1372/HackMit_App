//
//  ContentView.swift
//  Testing
//
//  Created by Lin Lin Lee on 9/19/20.
//

import SwiftUI

struct ContentView: View {
    var infos: [InfoSheet] = []
    
    var body: some View {
        NavigationView {
            List(infos) { info in
                MovementTab(info: info)
            }
            .navigationBarTitle(Text("Phone Footprint Use"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(infos: testData)
    }
}

struct MovementTab: View {
    let info: InfoSheet
    var body: some View {
        NavigationLink(destination: MovementView()) {
            Image(systemName: "photo").cornerRadius(3.0)
            VStack(alignment: .leading) {
                Text(info.name)
                Text("\(info.footprint.removeZerosFromEnd()) CO2 used")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
