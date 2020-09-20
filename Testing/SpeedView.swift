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
    @State var on = true
    
    var userSpeed: [CGFloat] {
        return [30, 3.2, 67, 48, 96, 25]
//        return locationManager.allSpeeds ?? [0.0]
    }
    
    var totalday: Double {
        var total = 0.0
        for index in 0..<userSpeed.count{
            total += Double(userSpeed[index])
        }
        return total
    }
    
    var body: some View {
        ZStack{
            Color.pink.opacity(0.25)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Your Carbon Footprint From Movement Over Time").fontWeight(.bold).font(.title)
                        .multilineTextAlignment(.center)
                        .padding(.top, 100.0)
                        .navigationBarTitle(Text("Movement Footprint"))
                }
                LineGraph(dataPoints: userSpeed)
                    .trim(to: on ? 1 : 0)
                    .stroke(Color.green ,style: StrokeStyle(lineWidth: 3, lineJoin: .round))
                    .padding(.bottom, 10.0)
                    .aspectRatio(16/9, contentMode: .fit)
                    .padding(.bottom, 100.0)
                    .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.green.opacity(0.5), lineWidth: 2)
                        .padding(.bottom, 100.0)
                    )
                VStack {
                    Text("Total: \(Int(totalday))g CO2").fontWeight(.bold).font(.title)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20.0)
                    Text("From Data: \(SystemDataUsage.wifiCompelete/1000000000) kg CO2").fontWeight(.bold).font(.title)
                        .multilineTextAlignment(.center)
                        
                    Text("From Wifi: \(SystemDataUsage.wwanCompelete/1000000000) kg CO2").fontWeight(.bold).font(.title)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

struct MovementView_Previews: PreviewProvider {
    static var previews: some View {
        MovementView()
    }
}

struct LineGraph: Shape {
    var dataPoints: [CGFloat]

    func path(in rect: CGRect) -> Path {
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count + 1)
            let y = (rect.height - point)
            return CGPoint(x: x+30, y: y)
        }
        
        guard dataPoints.count > 1 else { return Path{_ in }}
        let start = dataPoints[0]
        print(dataPoints)
        return Path { p in
            p.move(to: CGPoint(x: 30, y: rect.height - start))
            for idx in dataPoints.indices {
                p.addLine(to: point(at: idx))
            }
        }
    }
}

#endif
