//: [Previous](@previous)

import Foundation

// Checkpoint 7
class Animal {
    let legs: Int

    init (legs: Int) {
        self.legs = legs
    }
    
    func speak() {
        print("hmmm")
    }
}

class Dog : Animal {
    
    override func speak() {
        print("bark")
    }
}

class Cat : Animal {
    
    var isTame: Bool
    
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame

        super.init(legs: legs)
    }
    
    override func speak() {
        print("meow")
    }
}

let tabby = Cat(legs: 4, isTame: true)
tabby.speak()

// Opaque return types
func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber())
//print(getRandomNumber() == getRandomBool())


protocol Shape {
    func draw()-> String
}

struct Triangle: Shape {
    var size: Int
    func draw()-> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String (repeating: "x", count: length))
        }
            return result.joined(separator: "\n")
    }
}
let smallTriangle = Triangle(size: 3)
print (smallTriangle.draw())

struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw()-> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}
let flippedTriangle = FlippedShape (shape: smallTriangle)
print (flippedTriangle.draw())

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw()-> String {
        return top.draw() + "\n" + bottom.draw()
    }
}
let joinedTriangles = JoinedShape (top: smallTriangle, bottom: flippedTriangle)
print (joinedTriangles.draw())

struct Square: Shape {
    var size: Int
    
    func draw()-> String {
        let line = String (repeating: "x", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined (separator: "\n")
    }
}
let square=Square(size: 4)
print(square.draw())


func makeTrapezoid() -> some Shape {
    let top = Triangle (size: 2)
    let middle = Square (size: 3)
    let bottom = FlippedShape (shape: top)
    let trapezoid = JoinedShape(top: top,
                                bottom: JoinedShape(top: middle, bottom: bottom))
    return trapezoid
}

let trapezoid = makeTrapezoid()
print(trapezoid.draw())
    
    




//: [Next](@next)
