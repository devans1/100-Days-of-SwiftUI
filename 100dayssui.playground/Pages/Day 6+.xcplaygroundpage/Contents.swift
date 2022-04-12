//: [Previous](@previous)

import Foundation


// Day 7
// Do 2 strings contains the same letters


func myCompare(ls: String, rs: String) -> Bool {
    ls.sorted() == rs.sorted()
}
myCompare(ls: "fred", rs: "redfa")


// Checkpoint 4

enum sqrtError : Error {
    case outOfBounds
    case noRoot
}

func squareRoot(number: Int) throws -> Int {
    if (number < 1 || number > 10_000) {
        throw sqrtError.outOfBounds
    }
    
    for i in 1...100 {
        if i*i == number {
            return i
        }
    }
    throw sqrtError.noRoot
}

do {
    try print(squareRoot(number: 6561))
} catch sqrtError.noRoot {
    print("No root")
} catch sqrtError.outOfBounds {
    print("Out of bounds")
}

//: [Next](@next)
