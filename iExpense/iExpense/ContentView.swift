//
//  ContentView.swift
//  iExpense
//
//  Created by David Evans on 19/4/2022.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct SecondView: View {
    let name: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Hello, \(name)!")
            Button(action: {
                dismiss()
            }, label: {
                Text("Dismiss?")
            })
        }
    }
}

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

    var body: some View {
//        print("\(user.firstName) \(user.lastName)") ; return
        NavigationView {
            VStack {
                Spacer()
                Spacer()
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                Spacer()
                Button("Tap Count: \(tapCount)") {
                    tapCount += 1
                    UserDefaults.standard.set(tapCount, forKey: "Tap")
                }
                Spacer()
            }
            .navigationTitle("onDelete()")
            .toolbar(content: {
                EditButton()
            })
        }

    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
