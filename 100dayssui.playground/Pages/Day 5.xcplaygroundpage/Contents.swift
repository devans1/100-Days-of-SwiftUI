//: [Previous](@previous)

import Foundation

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works great on \(os).")
}

for i in 0...12 {
    print("The \(i) times table:")

    for j in 0...12 {
        print("  \(j) x \(i) is \(j * i)")
    }

    print()
}


// Checkpoint 3
for i in 1...100 {

    let multiple3 = i.isMultiple(of: 3)
    let multiple5 = i.isMultiple(of: 5)
    
    if (multiple3 && multiple5) {
        print("FizzBuzz")
    } else if multiple3 {
        print("Fizz")
    } else if multiple5 {
        print("Buzz")
    } else {
        print("\(i)")
    }
}

// Optimised
for i in 1...100 {

    if (i.isMultiple(of: 3)) {
        if (i.isMultiple(of: 5)) {
            print("FizzBuzz")
        } else {
            print("Fizz")
        }
    } else if (i.isMultiple(of: 5)) {
        print("Buzz")
    } else {
        print("\(i)")
    }
}



//: [Next](@next)
