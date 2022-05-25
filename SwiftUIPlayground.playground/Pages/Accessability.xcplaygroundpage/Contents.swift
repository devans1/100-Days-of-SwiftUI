//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        Text("SwiftUI in a playground!")
//    }
//}

struct Test: View {
    var body: some View {
        Text("Hmm")
    }
}


struct ContentView: View {
    let Test1: Test? = nil
    let Test2: Test? = Test()
    
    let a : 

    var body: some View {
        
        VStack {
            Circle()
                .frame(minWidth: 200)
            Text("Hmmm")
            Test()
            Test1
            Test2
            Capsule(style: .continuos
        }
    }
}

let viewController = UIHostingController(rootView: ContentView())

PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true



//: [Next](@next)
