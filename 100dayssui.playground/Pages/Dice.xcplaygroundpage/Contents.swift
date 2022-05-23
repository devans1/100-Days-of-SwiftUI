//: [Previous](@previous)

import Foundation


typealias DiceResult = [Int]

class DiceSet {

    var history: [DiceResult] = []
    
    func rollDice(numberDice: Int, numberSides: Int) -> DiceResult {
        let results = (1...numberDice).map { _ in return Int.random(in: 1...numberSides) }
        history.append(results)
        return results
    }
    
    init() {
        self.history = []
    }
    
    
    fileprivate convenience init(numberDice: Int, numberSides: Int) {
        self.init()
        _ = rollDice(numberDice: numberDice, numberSides: numberSides)
    }

    static var example = DiceSet(numberDice: 3, numberSides: 6)
}

let dice = DiceSet()
dice.rollDice(numberDice: 3 , numberSides: 6)
dice.rollDice(numberDice: 4 , numberSides: 12)
dice.rollDice(numberDice: 10 , numberSides: 50)
dice.history.map { print($0) }

print(DiceSet.example.rollDice(numberDice: 3, numberSides: 6))

Array(1...10).indices

//: [Next](@next)
