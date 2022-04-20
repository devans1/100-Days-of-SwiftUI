//
//  ContentView.swift
//  Moonshot
//
//  Created by David Evans on 20/4/2022.
//

import SwiftUI


struct ContentView: View {
    @AppStorage("showingGrid") private var showingGrid = true

    private var buttonTitle: String {
        showingGrid ? "List view" : "Grid view"
    }

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        NavigationView {
            Group {
                if (showingGrid) {
                    ListLayout(missions: missions, astronauts: astronauts)
                } else {
                    GridLayout(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar(content: {
                Button {
                    showingGrid.toggle()
                } label: {
                    if showingGrid {
                        Label("Show as grid", systemImage: "square.grid.2x2")
                    } else {
                        Label("Show as table", systemImage: "list.dash")
                    }
                        
//                    Text(buttonTitle)
//                        .foregroundColor(.white)
                }
            })
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
