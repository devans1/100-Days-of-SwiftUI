//
//  ContentView.swift
//  Flashzilla-prep
//
//  Created by David Evans on 16/5/2022.
//

import CoreHaptics
import SwiftUI


struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    
    @State private var currentAngle = Angle.zero
    @State private var finalAngle = Angle.zero

    // how far the circle has been dragged
    @State private var offset = CGSize.zero
    
    // whether it is currently being dragged or not
    @State private var isDragging = false
    
    // even though it is a class using @State makes sure it stays alive even when ContentView is recreated again and again
    @State private var engine: CHHapticEngine?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0

    @State private var scale = 1.0
    
    var body: some View {
        
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)
                
        
        VStack {
            Group {
                Spacer()
                
                Text("Press timing")
                    .onLongPressGesture(minimumDuration: 1) {
                        print("Long pressed!")
                    } onPressingChanged: { inProgress in
                        print("In progress: \(inProgress)!")
                    }
                
                Spacer()
                
                Text("Magnification!")
                    .scaleEffect(finalAmount + currentAmount)
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ amount in
                                print("amount=\(amount)")
                                currentAmount = amount - 1
                            })
                            .onEnded({ _ in
                                finalAmount += currentAmount
                                currentAmount = 0
                            })
                    )
                
                Spacer()
                
                Text("Rotation!")
                    .font(.title)
                    .rotationEffect(finalAngle + currentAngle)
                    .gesture(
                        RotationGesture()
                            .onChanged({ amount in
                                print("amount=\(amount)")
                                currentAngle = amount
                            })
                            .onEnded({ _ in
                                finalAngle += currentAngle
                                currentAngle = .zero
                            })
                    )

                Spacer()
            }
            
            // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
            Circle()
                .fill(.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
                .onReceive(timer) { time in
                    if counter == 5 {
                        timer.upstream.connect().cancel()
                    } else {
                        print("The time is now \(time)")
                    }
                    counter += 1
                }
            
            Spacer()
            
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }

                Text("Success")
                    .padding()
                    .background(differentiateWithoutColor ? .black : .green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            
            Spacer()
            
            Group {
                Text("Hello, World!")
                    .scaleEffect(scale)
                    .onTapGesture {
                        withOptionalAnimation {
                            scale *= 1.5
                        }
                    }
                Spacer()
                
                Text("Hello, World!")
                            .padding()
                            .background(reduceTransparency ? .black : .black.opacity(0.5))
                            .foregroundColor(.white)
                            .clipShape(Capsule())

                Spacer()
            }
        }
        .contentShape(Rectangle())
        .highPriorityGesture(
        TapGesture()
            .onEnded({
//                simpleSuccess()
                complexSuccess()
                print("VStack tapped")
            }))
        .onAppear(perform: prepareHaptics)
        .onChange(of: scenePhase) { newPhase in
                        if newPhase == .active {
                            print("Active")
                        } else if newPhase == .inactive {
                            print("Inactive")
                        } else if newPhase == .background {
                            print("Background")
                        }
                    }
//        .onTapGesture {
//            print("VStack tapped")
//        }
    }
    
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
//        events.append(event)

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
