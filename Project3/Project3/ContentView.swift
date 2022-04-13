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
//            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.primary)
                .padding(5)
                .background(.background)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}



/// <#Description#>
struct ContentView: View {
    var body: some View {
        VStack {
            CapsuleText(capsuleText: "First")
                .foregroundColor(.red)
            CapsuleText(capsuleText: "Second")
                .foregroundStyle(.regularMaterial)
            Text("Hmmmmm<->")
//                .modifier(Title())
                .titleStyle()
                .watermarked(with: "DE")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
