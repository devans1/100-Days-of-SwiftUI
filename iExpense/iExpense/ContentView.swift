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
    @StateObject private var user = User()
    @State private var showingSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1


    var body: some View {
        print("\(user.firstName) \(user.lastName)") ; return
        VStack {
            Spacer()
            Button(action: {
                showingSheet.toggle()
            }, label: {
                Text("Show sheet")
            })
            
            Spacer()
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
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
        }
        .sheet(isPresented: $showingSheet) {
            // contents of the sheet
            SecondView(name: "@TwoStraws")
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
