//
//  Friend.swift
//  Friends
//
//  Created by David Evans on 27/4/2022.
//

import Foundation

struct Friend : Identifiable, Codable {
    let id: UUID
    var name: String
}
