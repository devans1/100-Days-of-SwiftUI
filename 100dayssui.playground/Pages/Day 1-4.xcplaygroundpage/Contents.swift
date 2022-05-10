import Cocoa

// Day 1

let character = "Daphne"

var playerName = "Roy"
print(playerName)

playerName = "Dani"
print(playerName)

playerName = "Sami"
print(playerName)

let quote = """
Then he tapped a
sign saying \"Believe\" and walked away.
"""

print (quote.uppercased().hasPrefix("TH"))

let reallyBig=1_000_000
print(reallyBig)

var counter=10
counter += 5

let number = 120
print(number.isMultiple(of: 3))

let number2 = 0.1 + 0.2
print(number2)

let a = 1
let b = 2.0
let c = Double(a) + b
print(c)

//
// Ignore CGFload it is old and equivalent to Double - swift will use double.
//

var gameOver = false
print(gameOver)

//
// Toggle boolean
//
gameOver.toggle()
print(gameOver)

//let missionMessage = "Apollo " + String(number) + " landed on the moon."
let missionMessage = "Apollo \(number) landed on the moon."


// Checkpoint 1

// Day 2

let celsius = 0.0
let fahrenheit = celsius * 9.0 / 5.0 + 32.0

print("The temperature in Celsius is \(celsius)° and equals \(fahrenheit)°!")

let presidents = ["Bush", "Obama", "Trump", "Biden"]
let sortedPresidients = presidents.sorted()
let reversedPresidents = sortedPresidients.reversed()

print(reversedPresidents)
print(reversedPresidents.last as Any)

// sets are FAST
var people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])
people.insert("Fred")
print(people)
people.contains("Fred")
people.customMirror.subjectType

let p=people.sorted()
p.customMirror.subjectType

// Day 4

enum Weekday {
    case monday, tuesday, wednesday
    case thursday
    case friday
}

var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday

// OK made a change

// Some test stuff - good way of sorting though.
let files = ["N10-13-1", "N11-3-2", "N3-2-1"]

let custom = files.sorted { (lhs: String, rhs: String) -> Bool in
    return lhs.compare(rhs, options: [.numeric], locale: .current) == .orderedAscending
}

// CHeckpoint 2.

var people1 = ["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"]
people1.append("Fred")
people1.append("Fred")

people1.count
let uniquePeople1 = Set(people1)
uniquePeople1.count

