//
//  Contact+CoreDataProperties.swift
//  Contacts
//
//  Created by David Evans on 11/5/2022.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var photo: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension Contact : Identifiable {

}
