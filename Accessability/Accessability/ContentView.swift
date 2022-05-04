//
//  ContentView.swift
//  Accessability
//
//  Created by David Evans on 5/5/2022.
//

import SwiftUI

struct ContentView: View {
    
    let pictures = [
            "ales-krivec-15949",
            "galina-n-189483",
            "kevin-horstmann-141705",
            "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    @State private var value = 10
    
    var body: some View {
        VStack {
            
            Image(decorative: "nicolas-tissot-335096")
                .resizable()
                .scaledToFit()
                .accessibilityHidden(true)
            
            Spacer()
            VStack {
                Text("Value: \(value)")

                Button("Increment") {
                    value += 1
                }

                Button("Decrement") {
                    value -= 1
                }
            }
            .accessibilityElement()
            .accessibilityLabel("Value")
            .accessibilityValue(String(value))
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    value += 1
                case .decrement:
                    value -= 1
                default:
                    print("Not handled.")
                }
            }
            
            Spacer()
            
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }
            .accessibilityElement(children: .ignore)    // these are the default parameters
            .accessibilityLabel("Your score is 1000")

            Spacer()
            
            Image(pictures[selectedPicture])
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    selectedPicture = Int.random(in: 0...3)
                }
                .accessibilityLabel(labels[selectedPicture])
                .accessibilityAddTraits(.isButton)
                .accessibilityRemoveTraits(.isImage)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
