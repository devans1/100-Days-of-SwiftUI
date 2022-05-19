//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by David Evans on 18/5/2022.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    let opacityStart = 300.0
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        let posnFromTop = geo.frame(in: .global).minY
                        let posnFromTopPercent = max(0.6, posnFromTop / (fullView.size.height / 2.0))
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
//                            .background(colors[index % 7])
                            .background(Color(hue: min(1, geo.frame(in: .global).minY / fullView.size.height), saturation: 1, brightness: 1))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(posnFromTop / opacityStart)
                            .scaleEffect(CGSize(width: posnFromTopPercent, height: posnFromTopPercent))
                    }
                    .frame(height: 40)
                }
            }
        }
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                ForEach(1..<20) { num in
//                    GeometryReader { geo in
//                        Text("Number \(num)")
//                            .font(.largeTitle)
//                            .padding()
//                            .background(colors[num % 7])
//                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
//                            .frame(width: 200, height: 200)
//                    }
//                    .frame(width: 200, height: 200)
//                }
//            }
//        }
//        GeometryReader { fullView in
//            ScrollView {
//                ForEach(0..<50) { index in
//                    GeometryReader { geo in
//                        Text("Row #\(index)")
//                            .font(.title)
//                            .frame(maxWidth: .infinity)
//                            .background(colors[index % 7])
//                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height /  2) / 5,
//                                              axis: (x: 0, y: 1, z: 0))
//                    }
//                    .frame(height: 40)
//                }
//            }
//        }
//        VStack {
//            OuterView()
//                        .background(.red)
//                        .coordinateSpace(name: "Custom")
//            GeometryReader { geo in
//                        Text("Hello, Witch World!")
//                            .frame(width: geo.size.width * 0.9)
//                            .background(.red)
//                    }
//            .background(.green)
//            Image("example")    // images are not resizable until you put them in a view to do so
//                .resizable()
//                .scaledToFit()
//                .frame(width: 200, height: 200)
//                .clipped()
//            Color.yellow // layout neutral
//            Text("Hello, world!")
//                .padding(20)
//                .background(.red)
//            Text("Hello, world!")
//                .background(.red)
//                .padding(20)
//            Text("Live long and prosper")
//                .frame(width: 300, height: 300, alignment: .topLeading)
//                .offset(x: 50, y: 50)
//            HStack(alignment: .bottom) {
//                Text("Live")
//                    .font(.caption)
//                Text("long")
//                Text("and")
//                    .font(.title)
//                Text("prosper")
//                    .font(.largeTitle)
//            }
//            HStack(alignment: .lastTextBaseline) {
//                Text("Live")
//                    .font(.caption)
//                Text("long")
//                Text("and")
//                    .font(.title)
//                Text("prosper")
//                    .font(.largeTitle)
//            }
//            VStack(alignment: .leading) {
//                Text("Hello, world!   ")
//                    .alignmentGuide(.leading) { d in
//                    d[.trailing]
//                }
//                    .offset(x: -10, y: 0)
//                        Text("This is a longer line of text")
//                    }
//                    .background(.red)
//                    .frame(width: 400, height: 80)
//                    .background(.blue)
//            VStack(alignment: .leading) {
//                    ForEach(0..<10) { position in
//                        Text("Number \(position)")
//                            .alignmentGuide(.leading) { _ in CGFloat(position) * -20 }
//                    }
//                }
//                .background(.red)
//                .frame(width: 400, height: 250)
//                .background(.blue)
//            HStack (alignment: .midAccountAndName) {
//                VStack {
//                    Text("@twostraws")
//                        .alignmentGuide(.midAccountAndName) { d in
//                            d[VerticalAlignment.center]
//                        }
//                    Image("example")
//                        .resizable()
//                        .frame(width: 64, height: 64)
//                }
//
//                VStack {
//                    Text("Full name:")
//                    Text("PAUL HUDSON")
//                        .font(.largeTitle)
//                        .alignmentGuide(.midAccountAndName) { d in
//                            d[VerticalAlignment.center]
//                        }
//                }
//            }
//            Text("Hello, world!")
//                .background(.red)
//                .position(x: 100, y: 100)
//                .frame(width: 300, height: 300)
//            Text("Hello, world!")
//                .offset(x: 100, y: 100)
//                .background(.red)   // swap them and it is correct
//            GeometryReader { geo in
//                        Text("Hello, World!")
//                            .frame(width: geo.size.width * 0.9)
//                            .background(.red)
//                    }
//            GeometryReader { geo in
//                        Text("Hello, Witch World!")
//                            .background(.red)
//                    }
//            Text("Hello, Witch World!")
//                .background(.blue)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
