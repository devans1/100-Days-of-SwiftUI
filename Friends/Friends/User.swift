//
//  User.swift
//  Friends
//
//  Created by David Evans on 27/4/2022.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    var activeDescription: String {
        get {
            isActive ? "active" : "inactive"
        }
    }
    var tagsList: String {
        get {
            return tags.joined(separator: ",")
        }
    }

    var friendsList: String {
        get {
            friends.map {
                $0.name
            }.joined(separator: ",")
        }
    }

    
    static let example = User(id: UUID(), isActive: true, name: "Paul Hudson", age: 35, company: "Hudson Heavy Industries", email: "paul@hackingwithswift.com", address: "555, Taylor Swift Avenue, Nashville, Tennessee", about: "Paul writes about Swift and iOS development.", registered: Date.now, tags: ["swift", "swiftui", "dogs"], friends: [])

}

extension User {
    
    init(cachedUser: CachedUser) {
        self.id = cachedUser.id ?? UUID()
        self.isActive = cachedUser.isActive
        self.name = cachedUser.wrappedName
        self.age = Int(cachedUser.age)
        self.company = cachedUser.company ?? "company is nil"
        self.email = cachedUser.email ?? "email is nil"
        self.address = cachedUser.address ?? "address is nil"
        self.about = cachedUser.about ?? "about is nil"
        self.registered = cachedUser.registered ?? Date.distantPast
        self.tags = cachedUser.tags?.components(separatedBy: ",") ?? []
        self.friends = cachedUser.friendArray.map {
            Friend(cachedFriend: $0)
        }
    }
    
}
