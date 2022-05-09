//
//  Contact.swift
//  Contacts
//
//  Created by David Evans on 9/5/2022.
//

import Foundation

struct Contact: Identifiable, Codable, Comparable {
//    var id: ObjectIdentifier
    var id: UUID
    
    let name: String
    let photo: String
    
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name < rhs.name
    }
    
    static var example = Contact(id: UUID(), name: "David", photo: "Photoname")
}
