//: [Previous](@previous)

import Foundation

// Checkpoint 6

struct Car {
    let model: String
    let numberSeats: Int
    private(set) var gear: Int = 1
    
//    init(model: String,
//         numberSeats: Int) {
//        self.model = model
//        self.numberSeats = numberSeats
//    }
    
    mutating func changeGear(by: Int) {
        if gear + by < 1 || gear + by > 10 {
            return
        }
        gear += by
    }
}

var bill = Car(model: "Datsun", numberSeats: 4)
bill.changeGear(by: -1)
print(bill)
bill.changeGear(by: 1)
print(bill)
bill.changeGear(by: 1)
print(bill)
bill.changeGear(by: 2)
print(bill)



//: [Next](@next)
