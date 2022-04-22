//
//  Order.swift
//  CupcakeCorner
//
//  Created by David Evans on 22/4/2022.
//

import SwiftUI


@dynamicMemberLookup
class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
//    enum CodingKeys: CodingKey {
//        case orderDetails
//    }
    
    @Published var orderDetails = OrderDetails()

    // for reading - "KeyPath" - not sure why KeyPath and WriteableKeyPath are needed, just have Writeable?
    subscript<T>(dynamicMember keyPath: KeyPath<OrderDetails, T>) -> T {
        orderDetails[keyPath: keyPath]
    }
    
    // for writing - "WritableKeyPath"
    subscript<T>(dynamicMember keyPath: WritableKeyPath<OrderDetails, T>) -> T {
        get {
            orderDetails[keyPath: keyPath]
        }
        
        set {
            orderDetails[keyPath: keyPath] = newValue
        }
    }
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(orderDetails, forKey: .orderDetails)
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        orderDetails = try container.decode(OrderDetails.self, forKey: .orderDetails)
//    }
//    
//    init() { }
}

struct OrderDetails: Codable {
//    enum CodingKeys: CodingKey {
//        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//    }
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty
            || streetAddress.isEmpty
            || city.isEmpty
            || zip.isEmpty
            || name.trimmingCharacters(in: .whitespaces).isEmpty            // EXTEND String to do this!!
            || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty
            || city.trimmingCharacters(in: .whitespaces).isEmpty
            || zip.trimmingCharacters(in: .whitespaces).isEmpty
        {
            return false
        }

        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//
//    init() { }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
    
}

