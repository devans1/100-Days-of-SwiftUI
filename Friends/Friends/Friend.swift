//
//  Friend.swift
//  Friends
//
//  Created by David Evans on 27/4/2022.
//

import Foundation

public struct Friend : Identifiable, Codable, Hashable {
    public let id: UUID
    var name: String
}

extension Friend {
    
    init(cachedFriend: CachedFriend) {
        self.id = cachedFriend.id ?? UUID()
        self.name = cachedFriend.wrappedName
    }
}
