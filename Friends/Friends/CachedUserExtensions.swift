//
//  CachedUserExtensions.swift
//  Friends
//
//  Created by David Evans on 29/4/2022.
//
import CoreData
import Foundation


extension CachedUser {
    
    public var wrappedName: String {
        self.name ?? "name is nil"
    }
    
    public var tagsArray: [String] {
        get { return tags?.components(separatedBy: ",") ?? [] }
//        set { tags = newValue.joined(separator: ",") }
    }
            
    var friendArray: [CachedFriend] {
        let set = self.friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

