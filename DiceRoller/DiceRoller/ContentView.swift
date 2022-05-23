//
//  ContentView.swift
//  DiceRoller
//
//  Created by David Evans on 23/5/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var diceSet = DiceSet()
    @State private var numberDice: Int = 6
    @State private var numberSides: Int = 20

    @State var roll: DiceResult = [1,2,3,4,5,6]

    let steps = 20
    @State var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    @State private var angle = Angle.zero

    var body: some View {
        NavigationView {
            ZStack {
                HStack {
                    ForEach(roll.indices, id: \.self) { index in
                        Text("\(roll[index])")
                            .frame(minWidth: 30)
                            .padding([.top, .bottom])
                            .background(.green.opacity(0.5))
                            .rotation3DEffect(angle,
                                              axis: (x: 1, y: 0, z: 0),
                                              anchor: UnitPoint.center,
                                              anchorZ: -200,
                                              perspective: 0)
                    }
                }
            }
            .navigationTitle("Roller")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Roll") {
                        doRoll()
                        timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
                    }
                }
            }
        }
        .onReceive(timer) { time in
            if counter == steps+1 {
                timer.upstream.connect().cancel()
                counter = 0
            } else {
                angle = .degrees(-Double(counter) / Double(steps) * 360)
//                roll = DiceSet.roll(numberDice: numberDice, numberSides: numberSides)
//                print("Counter \(counter), angle \(angle.degrees)")
            }
            counter += 1
        }
    }
        
    func doRoll() {
        roll = DiceSet.roll(numberDice: numberDice, numberSides: numberSides)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(roll: [1,2,3,4,5,6])
    }
}
