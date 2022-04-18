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


struct ContentView: View {
    @StateObject private var user = User()

    var body: some View {
        print("\(user.firstName) \(user.lastName)") ; return
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
