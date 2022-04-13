//
//  ContentView.swift
//  Project3
//
//  Created by David Evans on 13/4/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Hello, world!") {
            print(type(of: self.body))
        }
        .frame(width: 200, height: 200)
        .background(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
