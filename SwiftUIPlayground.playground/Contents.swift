import UIKit
import PlaygroundSupport
import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        Text("SwiftUI in a playground!")
//    }
//}

struct ContentView: View {
    var body: some View {
        TimelineView(.animation) { context in
            let value = secondsValue(for: context.date)

            Circle()
                .trim(from: 0, to: value)
                .stroke()
        }
    }

    private func secondsValue(for date: Date) -> Double {
        let seconds = Calendar.current.component(.second, from: date)
        return Double(seconds) / 60
    }
}

let viewController = UIHostingController(rootView: ContentView())

PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true


