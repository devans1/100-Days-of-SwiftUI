//
//  ContentView.swift
//  Exam-Scratch
//
//  Created by David Evans on 24/5/2022.
//

import SwiftUI


struct TestView: View {
    @State var text: String
    
    enum SomeEnum: CaseIterable {
        case one, two, three
    }
    
    var body: some View {
        let e: SomeEnum = .one
        
        switch e {
        case .one:
            Text("one")
        default:
            Text("Other")
        }
        Text(text)
    }
}

struct ContentView: View {
    let Test1: TestView? = nil
    let Test2: TestView? = TestView(text: "Test2")
    
    @State private var lemon = TestView(text: "lemon")

    var body: some View {
        
        VStack {
            Text("Hello, world!")
                .padding()
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(maxWidth: 200)
            
            Image(systemName: "bell.fill")
                .resizable()
                .frame(width: 50, height: 50)
                
            Text("Hmmm")
                .foregroundColor(.blue)
            TestView(text: "test1")
                .background(.blue)
            Test1
            Test2
            lemon
            Capsule(style: .continuous)
                .frame(width: 40, height: 20)
            Spacer()
            
//            HStack(alignment: .firstTextBaseline) {
//                Text("Juicy")
//                    .font(.title)
//                Text("Hmm how big will it get before there is a problem")
//                    .font(.caption)
//                Text("Lucy")
//            }
        }
        .foregroundColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
