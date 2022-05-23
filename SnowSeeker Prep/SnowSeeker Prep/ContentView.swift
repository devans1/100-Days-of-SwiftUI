//
//  ContentView.swift
//  SnowSeeker Prep
//
//  Created by David Evans on 23/5/2022.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]

    
    var body: some View {
        
        NavigationView {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
        
        if sizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack(content: UserView.init)
        }
        
        //        if sizeClass == .compact {  // if do this on Pro Max it goes horizontal
        //            VStack {
        //                UserView()
        //            }
        //        } else {
        //            HStack {
        //                UserView()
        //            }
        //        }
        
        //        NavigationView {
        //            NavigationLink {
        //                Text("Show a new secondary")
        //            } label: {
        //                Text("Hello, World! in the first view")
        //            }
        //            .navigationTitle("Primary view")
        
        //            Text("Secondary view")
        //            Text("And a third view")
        //            Text("And a fourth view")
        //            Text("And a fifth view")
        //            Text("Hello, World!")
        //                .onTapGesture {
        //                    selectedUser = User()
        //                    isShowingUser = true
        //                }
        //                .sheet(item: $selectedUser) { user in
        //                    Text(user.id)
        //                }
        //                .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
        //                    Button(user.id) { }
        //                }
        //                .alert("Welcome", isPresented: $isShowingUser) { }
    }
    
    var filteredNames: [String] {
            if searchText.isEmpty {
                return allNames
            } else {
                return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
