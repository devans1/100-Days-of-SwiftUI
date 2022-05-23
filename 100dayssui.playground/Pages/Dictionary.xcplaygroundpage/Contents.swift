//: [Previous](@previous)

import Foundation


var test = [String: Int]()
test["one"]=1
test["two"]=2

if test[""] == nil {
    print("Woohoo")
}


enum NetworkError: Error {
    case badURL
}

func createResult() -> Result<String, NetworkError> {
    return .failure(.badURL)
}

let result = createResult()

do {
    let successString = try result.get()
    print(successString)
} catch {
    print("Oops! There was an error.")
}


//: [Next](@next)
