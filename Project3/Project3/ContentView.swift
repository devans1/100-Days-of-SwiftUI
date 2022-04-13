//
//  ContentView.swift
//  Project3
//
//  Created by David Evans on 13/4/2022.
//

import SwiftUI

struct CapsuleText: View {
    var capsuleText: String

    var body: some View {
        Text(capsuleText)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            CapsuleText(capsuleText: "First")
            CapsuleText(capsuleText: "Second")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
