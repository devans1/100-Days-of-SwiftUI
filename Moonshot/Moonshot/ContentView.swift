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
    }

    init(_ text: String) {
        print("Creating a new CustomText \(text)")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
//            ScrollView(.vertical) {
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
                    List(0..<100) { row in
//                    ForEach(0..<100) {row in
                        NavigationLink {
                            Text("Row \(row)")
                        } label: {
                            Text("Item \(row)")
                        }
                    }
//                    .frame(maxWidth: .infinity)
                }
                
//            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
