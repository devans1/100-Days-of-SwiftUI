//
//  ExpenseItem.swift
//  iExpense
//
//  Created by David Evans on 19/4/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
