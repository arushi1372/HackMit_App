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
        return [4.7, 3.2, 5.6, 7.8, 9.0, 15]
//        return locationManager.allSpeeds ?? [0.0]
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Line Graph")
                .navigationBarTitle(Text("Movement Footprint"))
            }
            LineGraph(dataPoints: userSpeed)
                .trim(to: on ? 1 : 0)
                .stroke(Color.red, lineWidth: 2)
                .aspectRatio(16/9, contentMode: .fit)
                .border(Color.gray, width: 1)
                .padding()
//                .withAnimation(.easeInOut(duration: 2))
//            Button("Animate") {
//                withAnimation(.easeInOut(duration: 2)){
//                    self.on.toggle()
//                }
//            }
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
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = (rect.height - point)
            return CGPoint(x: x, y: y)
        }
        
        guard dataPoints.count > 1 else { return Path{_ in }}
        let start = dataPoints[0]
        print(dataPoints)
        return Path { p in
            p.move(to: CGPoint(x: 0, y: rect.height - start))
            for idx in dataPoints.indices {
                p.addLine(to: point(at: idx))
            }
        }
    }
}

#endif
