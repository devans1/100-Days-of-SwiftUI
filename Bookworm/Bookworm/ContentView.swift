//
//  ContentView.swift
//  Bookworm
//
//  Created by David Evans on 22/4/2022.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}


struct ContentView: View {
    @State private var rememberMe = false
    
    // Note that AppStorage and UserDefaults is not private so don't use if for any PII!!!
    @AppStorage("notes") private var notes = ""

    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack {
            Spacer()
            
            PushButton(title: "PushButton", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
            
            Spacer()
            
            NavigationView {
                TextEditor(text: $notes)
                    .navigationTitle("Notes")
                    .padding()
            }
            
            Spacer()
            
            List(students) { student in
                Text(student.name ?? "Unknown")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
