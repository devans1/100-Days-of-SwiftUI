//
//  CachedFriendExtensions.swift
//  Friends
//
//  Created by David Evans on 29/4/2022.
//

import CoreData
import Foundation

extension CachedFriend {
    
    public var friend: Friend {
        return Friend(id: id ?? UUID(),
                      name: wrappedName)
    }

    public var wrappedName: String {
        name ?? "Unknown Name"
    }
}
