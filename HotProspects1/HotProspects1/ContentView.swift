//
//  ContentView.swift
//  HotProspects1
//
//  Created by David Evans on 12/5/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var prospects = Prospects()

    @State private var sortOrder: ProspectsView.SortByType = .name
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none, sortOrder: $sortOrder)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted, sortOrder: $sortOrder)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted, sortOrder: $sortOrder)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        .environmentObject(prospects)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environmentObject(Prospects())
    }
    
}
