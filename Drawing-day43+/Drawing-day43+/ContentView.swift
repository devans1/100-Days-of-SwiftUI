//
//  ContentView.swift
//  Drawing-day43+
//
//  Created by David Evans on 21/4/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            path.closeSubpath()
        }
//        .fill(.blue)
        .stroke(.blue, lineWidth: 10)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
