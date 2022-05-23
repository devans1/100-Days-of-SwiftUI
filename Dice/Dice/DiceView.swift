//
//  DiceView.swift
//  Dice
//
//  Created by David Evans on 19/5/2022.
//

import SwiftUI

struct DiceView: View {
    
    let roll: DiceResult
    let numberDice: Int
    let numberSides: Int

    let steps = 20
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    @State private var angle = Angle.zero
    @State private var tempRoll: DiceResult = []

    var body: some View {
//        VStack(alignment: .center) {
//            GeometryReader { geoHStack in
//                let numberDice = CGFloat(roll.count)
//                HStack {
//                    ForEach(roll.indices, id: \.self) { index in
//                        GeometryReader { geo in
//                            Text("\(roll[index])")
//                                .frame(
//                                    width: (geoHStack.frame(in: .global).width/numberDice - 5*(numberDice-1)),
//                                    height: geo.frame(in: .global).minY,
//                                    alignment: Alignment(horizontal: .center, vertical: .center)
//                                )
//                                .background(.green.opacity(0.5))
//                                .rotation3DEffect(angle, axis: (x: 1, y: 0, z: 0))
//                        }
//                    }
//                }
//            }
//        }
        HStack {
            ForEach(roll.indices, id: \.self) { index in
                Text("\(roll[index])")
                    .frame(minWidth: 30)
                    .padding([.top, .bottom])
                    .background(.green.opacity(0.5))
                    .rotation3DEffect(angle,
                                      axis: (x: 1, y: 0, z: 0),
                                      anchor: UnitPoint.center,
                                      anchorZ: -20,
                                      perspective: 0)
            }
        }
        .onReceive(timer) { time in
            if counter == steps+1 {
                timer.upstream.connect().cancel()
                counter = 0
                tempRoll = roll
            } else {
                angle = .degrees(-Double(counter) / Double(steps) * 360)
                tempRoll = DiceSet.roll(numberDice: numberDice, numberSides: numberSides)
//                print("Counter \(counter), angle \(angle.degrees)")
            }
            counter += 1
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(roll: [5,2,6], numberDice: 3, numberSides: 6)
    }
}
