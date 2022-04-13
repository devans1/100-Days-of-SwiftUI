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

struct BlueTitle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func blueTitled() -> some View {
        modifier(BlueTitle())
    }
}


struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
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
            Text("New text")
                .blueTitled()
        }
        GridStack(rows: 3, columns: 4) {row, col in
//            HStack { not needed when add @ViewBuilder above
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row)-C\(col)")
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
