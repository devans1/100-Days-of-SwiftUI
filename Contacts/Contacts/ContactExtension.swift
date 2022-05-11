//
//  ContactExtension.swift
//  Contacts
//
//  Created by David Evans on 9/5/2022.
//

import Foundation
import CoreLocation

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
    
    var coordinate: CLLocationCoordinate2D {
        get {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }

    
    convenience init(name: String) {
        self.init()
        
        self.name = name
    }

    static let example = Contact(name: "Fred")
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
}
