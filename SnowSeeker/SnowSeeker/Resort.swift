//
//  Resort.swift
//  SnowSeeker
//
//  Created by David Evans on 23/5/2022.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    enum SortBy: String, CaseIterable {
        case name="Name",
             country="Country",
             none="None"
    }
    
    static func sortBy(resortAttribute: SortBy) -> (_ lhs: Resort, _ rhs: Resort) -> Bool {
        switch resortAttribute {
        case .name:
            return { lhs, rhs in lhs.name < rhs.name }
        case .country:
            return { lhs, rhs in lhs.country < rhs.country }
        case .none:
            return { _ , _  in false }
        }
    }
    
    
    // note that these are lazily loaded by Swift
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}

