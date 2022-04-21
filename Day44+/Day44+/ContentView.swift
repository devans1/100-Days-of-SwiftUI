//
//  ContentView.swift
//  Day44+
//
//  Created by David Evans on 21/4/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var insetAmount = 50.0
        
    // Checkerboard
    @State private var rows = 4
    @State private var columns = 4

    // Spirograph
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount = 1.0
    @State private var hue = 0.6
    
    // Arrow
    @State private var lineWidth = 200.0

    
    var body: some View {

        VStack(spacing: 0) {
            Spacer()
            
//            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
//                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
//                .frame(width: 300, height: 300)
//
//            Spacer()
//
//            Group {
//                Text("Inner radius: \(Int(innerRadius))")
//                Slider(value: $innerRadius, in: 10...150, step: 1)
//                    .padding([.horizontal, .bottom])
//
//                Text("Outer radius: \(Int(outerRadius))")
//                Slider(value: $outerRadius, in: 10...150, step: 1)
//                    .padding([.horizontal, .bottom])
//
//                Text("Distance: \(Int(distance))")
//                Slider(value: $distance, in: 1...150, step: 1)
//                    .padding([.horizontal, .bottom])
//
//                Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
//                Slider(value: $amount)
//                    .padding([.horizontal, .bottom])
//
//                Text("Color")
//                Slider(value: $hue)
//                    .padding(.horizontal)
//
//            }
            Spacer()
            Arrow(lineWidth: lineWidth)
                .frame(width: CGFloat(lineWidth), height: 300)
                .rotationEffect(Angle(degrees: 180))
            
            Slider(value: $lineWidth, in: 50...300)
            Spacer()
        }
            
//            Checkerboard(rows: rows, columns: columns)
//                .onTapGesture {
//                    withAnimation(.linear(duration: 3)) {
//                        rows = 8
//                        columns = 16
//                    }
//                }
                        
//            Spacer()
//
//            Trapezoid(insetAmount: insetAmount)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    //                withAnimation {
//                    insetAmount = Double.random(in: 10...90)
//                    //                }
//                }
//                .animation(.default, value: insetAmount)
//        }
        
    }
}

struct Arrow: Shape {
    var lineWidth: Double

    // this is an internal value to animations and it is being overwritten here
    // for these new Shapes, perhaps you need you need to define how to animate
    var animatableData: Double {
        get { lineWidth }
        set { lineWidth = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let widthShaftPercent = 0.3
        let lenShaftPercent = 0.6
        let wingOverlapPercent = 0.20
        let widthSideSpace  = (1.0-widthShaftPercent) / 2.0 * rect.width
        let lenShaft        = lenShaftPercent * rect.height
        let lenInnerWing    = rect.height - lenShaft
        let wingOverlap     = wingOverlapPercent * rect.height
        let lenArrowHead    = lenInnerWing + wingOverlap

        path.move(to:    CGPoint(x: rect.minX + widthSideSpace, y: rect.minY))                             // bottom left
        path.addLine(to: CGPoint(x: rect.minX + widthSideSpace, y: rect.minY + lenShaft))                  // up LHS under wing
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - lenArrowHead))                                 // out to LHS arrow side tip
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))                                               // tip of arrow
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - lenArrowHead))                                // out to RHS arrow side tip
        path.addLine(to: CGPoint(x: rect.maxX - widthSideSpace, y: rect.minY + lenShaft))                  // down RHS under wing
        path.addLine(to: CGPoint(x: rect.maxX - widthSideSpace, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + widthSideSpace, y: rect.minY))
        path.closeSubpath()
        
        return path
   }
}


struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double

    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount

        var path = Path()

        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        return path
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b

        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }

        return a
    }
}

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int

    var animatableData: AnimatablePair<Double, Double> {
        get {
           AnimatablePair(Double(rows), Double(columns))
        }

        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // figure out how big each row/column needs to be
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)

        // loop over all rows and columns, making alternating squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}


struct Trapezoid: Shape {
    var insetAmount: Double

    // this is an internal value to animations and it is being overwritten here
    // for these new Shapes, perhaps you need you need to define how to animate
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
   }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
