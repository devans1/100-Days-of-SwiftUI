//
//  ContentView.swift
//  Project6
//
//  Created by David Evans on 14/4/2022.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var enabled = false
    
    @State private var dragAmount = CGSize.zero
    
    let letters = Array("Hello SwiftUI")
    @State private var enabled1 = false
    @State private var dragAmount1 = CGSize.zero
    
    @State private var isShowingRed = false
    
    var body: some View {
        print("\(animationAmount) isShowingRed: \(isShowingRed)") ; return
        VStack {
            // How cool, it seems to call the rotation3DEffect from here too!
//            Stepper("Scale amount", value: $animationAmount.animation(.interpolatingSpring(stiffness: 10, damping: 1)), step: 360)
//
//            Spacer()
            
//            VStack {
//                Button("Tap Me") {
//                    withAnimation {
//                        isShowingRed.toggle()
//                    }
//                }
//
//                if isShowingRed {
//                    Rectangle()
//                        .fill(.red)
//                        .frame(width: 200, height: 200)
//                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
////                        .transition(.scale)
//                }
//            }
//
//            Spacer()

            ZStack {
                Rectangle()
                    .fill(.green)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
                
                if isShowingRed {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                } else {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
            .onTapGesture {
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            
            Button("Tap Me") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    animationAmount += 360
                }
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))

            Spacer()
            
            HStack(spacing: 0) {
                ForEach(0..<letters.count) { num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled1 ? .blue : .red)
                        .offset(dragAmount1)
                        .animation(.default.delay(Double(num) / 20),
                                   value: dragAmount1)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { dragAmount1 = $0.translation }
                    .onEnded { _ in
                        dragAmount1 = .zero
                        enabled1.toggle()
                    }
            )

            Spacer()
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: 300, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .offset(dragAmount)
                        .gesture(
                            DragGesture()
                                .onChanged { dragAmount = $0.translation }
                                .onEnded{ _ in
                                         withAnimation(.spring()) {
                                             dragAmount = .zero
                                         }
                                }
//                                .onEnded { _ in dragAmount = .zero }
                        )
//                        .animation(.spring(), value: dragAmount) // implicit animation
            Spacer()
            

            Button("Tap Me Too") {
                enabled.toggle()
            }
            .frame(width: 200, height: 100)
            .background(enabled ? .blue : .red)
            .animation(nil, value: enabled)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
            Spacer()

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
