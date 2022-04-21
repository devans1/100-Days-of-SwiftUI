//
//  ContentView.swift
//  Day44+
//
//  Created by David Evans on 21/4/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var colorCycle = 0.0

    @State private var amount = 0.0

    var body: some View {
        
        VStack {
//            ColorCyclingCircle(amount: colorCycle)
//                .frame(width: 300, height: 300)
//
//            Slider(value: $colorCycle)
            VStack {
                Image("Example")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .saturation(amount)
                    .blur(radius: (1 - amount) * 20)
                
                Slider(value: $amount)
            }
            
            
//            ZStack {
//                VStack {
//                    Image("Example")
//                        .resizable()
//                        .scaledToFit()
//                }
//                .frame(width: 300, height: 300)
//                .clipped()
//                .colorMultiply(.red.opacity(0.5))
//
//                // same as above colorMultiply effect
//                //                Rectangle()
//                //                    .fill(.red)
//                //                    .blendMode(.multiply)
//            }
            
            VStack {
                ZStack {
                    Circle()
                        .fill(Color(red: 1, green: 0, blue: 0)) // absolute red
                        .frame(width: 200 * amount)
                        .offset(x: 0, y: -80)
                        .blendMode(.screen)

                    Circle()
                        .fill(.red) // red for the environment
                        .frame(width: 200 * amount)
                        .offset(x: -50, y: -80)
                        .blendMode(.screen)
                    
                    Circle()
                        .fill(.green)
                        .frame(width: 200 * amount)
                        .offset(x: 50, y: -80)
                        .blendMode(.screen)
                    
                    Circle()
                        .fill(.blue)
                        .frame(width: 200 * amount)
                        .blendMode(.screen)
                }
                .frame(width: 300, height: 300)
                
                Slider(value: $amount)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
        }
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<steps) { value in
                    Circle()
                        .inset(by: Double(value))
    //                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    color(for: value, brightness: 1),
                                    color(for: value, brightness: 0.5)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 2)
                }
            }
            .drawingGroup()  // ONLY use this once you have identified that there is a performance problem.  It initiates use of Metal and renders stuff offscreen
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
