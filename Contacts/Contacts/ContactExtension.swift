//
//  ContactExtension.swift
//  Contacts
//
//  Created by David Evans on 9/5/2022.
//

import Foundation

extension Contact {
    
    var wrappedName: String {
        name ?? "Unknown name"
    }
    
    var wrappedPhoto: String {
        photo ?? "Unknown photo"
    }

    var wrappedID: String {
        id?.uuidString ?? "Unknown id"
    }
    
    var wrappedFileName: String {
        wrappedID + ".jpg"
    }

    static let example = Contact()
}

