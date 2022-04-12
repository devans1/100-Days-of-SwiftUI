//: [Previous](@previous)

import Foundation
import Cocoa

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func trim() {
        return self = self.trimmed()
    }
}

"   abcd  ".trimmed()

var fred = "   aaaa  "
print("fred->\(fred)<-")

fred.trim()
print("fred->\(fred)<-")


struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

// put it in an extension and you don't lose the automatic member-wise initialiser
extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

let lotr = Book(title: "lotr", pageCount: 2000, readingHours: 10)
print(lotr)
let lotr2 = Book(title: "lotr", pageCount: 1000)
print(lotr2)

// self is current instance value
// Self is the type
extension Numeric {
    func squared() -> Self {
        self * self
    }
}
5.squared()
5.5.squared()

// Checkpoint 8
protocol Building {
    var type: String { get }
    var numberRooms: Int { get }
    var cost: Double { get set }
    var estateAgentName: String { get set }
    
    func printSummary() -> String
}

extension Building {
    func printSummary() -> String {
        return "This \(type) has \(numberRooms) rooms, costs $\(cost) and is sold by \(estateAgentName) "
    }
}


struct House : Building {
    let type = "House"
    var numberRooms: Int
    var cost: Double
    var estateAgentName: String
    
//    func printSummary() -> String {
//         return "This house has \(numberRooms) rooms, costs $\(cost) and is sold by \(estateAgentName) "
//    }
}

struct Office : Building {
    let type = "Office"
    var numberRooms: Int
    var cost: Double
    var estateAgentName: String
    
//    func printSummary() -> String {
//         return "This office has \(numberRooms) rooms, costs $\(cost) and is sold by \(estateAgentName) "
//    }
}



let office=Office(numberRooms: 6, cost: 100.0, estateAgentName: "David")
let home=House(numberRooms: 2, cost: 50.4, estateAgentName: "Deb")

let list: [Building] = [office, home]

print(list.map { $0.printSummary() }.joined(separator: "\n"))

let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]

let peachOpposite = opposites["Peach"]

// number = number is called shadowing and is very common
func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        return
    }
    print("\(number) x \(number) is \(number * number)")
}
printSquare(of: 3)
printSquare(of: nil)

let names = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")

enum UserError: Error {
    case hmm, badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

//do {
//    let user = try getUser(id: 23)
//    print(user)
//} catch {
//    print(error)
//}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
} else {
    print("there was an error")
}
let user = (try? getUser(id: 23)) ?? "Anonymous"
print(user)

// Checkpoint 9
func generateRandom(input: [Int]?) -> Int {
    return input?.randomElement() ?? ((0...100).randomElement() ?? 0)
}


print(generateRandom(input: nil))
print(generateRandom(input: [1,2,3,4,5]))

func generateRandom1(input: [Int?]?) -> Int {
    let random = Int.random(in: 0...100)
    return (input?.randomElement() ?? random) ?? random
}


print(generateRandom1(input: nil))
print(generateRandom1(input: [1,2,3,4,5]))
print(generateRandom1(input: [1,nil,3,nil,5,nil]))
print(generateRandom1(input: [nil,nil,nil]))

func getNumber(in array: [Int?]?) -> Int {
    lazy var random = Int.random(in: 1...100)
    return (array?.randomElement() ?? random) ?? random
}
print(getNumber(in: nil))
print(getNumber(in: [1,2,3,4,5]))
print(getNumber(in: [1,nil,3,nil,5,nil]))
print(getNumber(in: [nil,nil,nil]))


//: [Next](@next)
