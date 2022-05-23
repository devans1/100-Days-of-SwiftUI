//
//  ContentView.swift
//  Dice
//
//  Created by David Evans on 19/5/2022.
//

import SwiftUI

struct ContentView: View {

    @State private var numberDice: Int = 3
    @State private var numberSides: Int = 6
    
    @State private var roll = DiceResult()
    @StateObject private var diceSet = DiceSet()
    
    var body: some View {

        NavigationView {
            Form {
                Section {
                    VStack {
                        Stepper("Number of dice \(numberDice)", value: $numberDice, in: 1...8)
                        Stepper("Sides on each dice \(numberSides)", value: $numberSides, in: 1...50)
                    }
                }
                                
                Section(content: {
                    DiceView(roll: roll, numberDice: numberDice, numberSides: numberSides)
                        .onChange(of: numberDice) { _ in
                            doRoll()
                        }
                        .onChange(of: numberSides) { _ in
                            doRoll()
                        }
                },
                        header: { Text("Roller") },
                        footer: { Text(" Total: \(roll.reduce(0) { accum, next in accum + next } )")}
                )

                Section {
                    List {
                        ForEach(diceSet.history.indices, id: \.self) { roll in
                            HStack {
                                ForEach(diceSet.history[roll].indices, id: \.self) { dice in
                                    Text("\(diceSet.history[roll][dice])")
                                }
                                Spacer()
                                Text("\(diceSet.history[roll].reduce(0) {accum, next in accum + next } )")
                            }
                        }
                    }
                } header: { Text("History") }
            }
            .navigationTitle("Roll the dice")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Roll") {
                        doSave()
                        doRoll()
                    }
                }
            }
        }
        .onAppear(perform: doRoll)
    }
    
    func doSave() {
        diceSet.save(roll: roll)
    }
    
    func doRoll() {
        roll = DiceSet.roll(numberDice: numberDice, numberSides: numberSides)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
