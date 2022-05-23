//
//  Dice.swift
//  Dice
//
//  Created by David Evans on 19/5/2022.
//

import Foundation

typealias DiceResult = [Int]

@MainActor class DiceSet: ObservableObject {

    @Published var history: [DiceResult] = []
    
    static func roll(numberDice: Int, numberSides: Int) -> DiceResult {
        return (1...numberDice).map { _ in return Int.random(in: 1...numberSides) }
    }
    
    func save(roll: DiceResult) {
        history.insert(roll, at: 0)
    }
    
    init() {
        self.history = []
    }
}
