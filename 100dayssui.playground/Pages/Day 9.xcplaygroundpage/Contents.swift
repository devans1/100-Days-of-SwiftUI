//: [Previous](@previous)

import Foundation

//let sayHello = {
//    print("Hi there!")
//}
//let test = sayHello
//test()

let sayHello = { (name: String) -> String in
    "Hi \(name)!"
}

let test = sayHello
test("David")

func greetUser() {
    print("Hi there!")
}

var greetCopy: () -> Void = greetUser
greetUser()

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})
print(captainFirstTeam)


func makeArray(size: Int, generator: () -> Int) -> [Int] {
    var numbers = [Int]()

    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}

let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}
print(rolls)


func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}

doImportantWork(first: { print("hmmm0") }, second: {print("second")}, third: {print("oh boo hooo")} )

// Checkpoint 5
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

let _ = luckyNumbers.filter { !$0.isMultiple(of: 2) }
    .sorted { $0 < $1}
    .map { print("\($0) is a lucky number") }

let _ = luckyNumbers.filter { !$0.isMultiple(of: 2) }
    .sorted()
    .map { print("\($0) is a lucky number") }


//: [Next](@next)
