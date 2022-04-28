//
//  UserView.swift
//  Friends
//
//  Created by David Evans on 28/4/2022.
//

import SwiftUI

struct UserView: View {
    var user: User
    
    var body: some View {
        List {
            Section {
                Text(user.about)
            } header: {
                Text("About")
            }
            Section {
                Text("Username: \(user.name)")
                Text("Online: \(user.activeDescription)")
                Text("Date: \(user.registered.formatted())")
                Text("Age: \(user.age)")
                Text("Company: \(user.company)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
                Text("Tags: \(user.tagsList)")
                Text("Friends: \(user.friendsList)")
            }
            
            Section {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            } header: {
                Text("Friends List")
            }

        }
        .navigationTitle("\(user.name)")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.grouped)
//        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            UserView(user: User.example)
        }
    }
}
