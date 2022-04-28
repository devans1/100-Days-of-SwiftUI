//
//  ContentView.swift
//  Friends
//
//  Created by David Evans on 27/4/2022.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        UserView(user: user)
                    } label: {
                        UserLabelView(user: user)
                    }
                }
            }
            .navigationTitle("Friends")
        }
        .task {
            await loadData()
        }
        
    }

    func loadData() async {
        guard users.isEmpty else { return }

        do {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                fatalError("Download of Friendface data failed")
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            users = try decoder.decode([User].self, from: data)
            
        } catch {
            fatalError("Decoding of Friendface data failed \(error.localizedDescription)")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
