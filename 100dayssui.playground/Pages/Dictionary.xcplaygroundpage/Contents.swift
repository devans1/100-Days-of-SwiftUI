//: [Previous](@previous)

import Foundation


var test = [String: Int]()
test["one"]=1
test["two"]=2

if test[""] == nil {
    print("Woohoo")
}


class DelayedUpdater: ObservableObject {
//    @Published var value = 0
    var value = 0 {
        willSet {
            print(value, newValue)
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}


//: [Next](@next)
