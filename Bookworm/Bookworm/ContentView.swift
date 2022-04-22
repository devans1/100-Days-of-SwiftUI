//
//  ContentView.swift
//  Bookworm
//
//  Created by David Evans on 22/4/2022.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        Text("hello world")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
