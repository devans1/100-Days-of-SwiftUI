//
//  ContentView.swift
//  Moonshot
//
//  Created by David Evans on 20/4/2022.
//

import SwiftUI

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption2)
    }

    init(_ text: String) {
        print("Creating a new CustomText \(text)")
        self.text = text
    }
}

//let layout = [
//    GridItem(.fixed(80)),
//    GridItem(.fixed(80)),
//    GridItem(.fixed(80))
//]

let layout = [
    GridItem(.adaptive(minimum: 80))
]


struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
//            ScrollView(.horizontal) {
                VStack(spacing: 10) {
                    GeometryReader { geo in
                        NavigationLink {
                            Text("Detail View")
                        } label: {
                            Image("Example")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.8)
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                    }
                    .frame(width: 100, height: 100)
//                    LazyHGrid(rows: layout) {
                    LazyVGrid(columns: layout) {
                        ForEach(0..<1000) { row in
                            CustomText("Item \(row)")
                        }
                    }
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
