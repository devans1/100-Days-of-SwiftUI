//
//  ExpenseSectionView.swift
//  iExpense
//
//  Created by David Evans on 19/4/2022.
//

import SwiftUI

struct ExpenseSectionView: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void

    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }

                    Spacer()

                    Text(item.amount, format: .localCurrency)
                        .style(for: item)
                }
                .foregroundColor((item.amount>200 ? .red : .primary))
                .accessibilityElement(children: .ignore)
//                .accessibilityLabel("\(item.name) expense of \(item.itemDollars) dollars and \(item.itemCents) cents") // my attempt
                .accessibilityLabel("\(item.name), \(item.amount.formatted(.currency(code: "USD")))") // this works OK, but localise
                .accessibilityLabel("\(item.name), \(item.formattedAmount)") // this is best
                .accessibilityHint("for \(item.type)")
            }
            .onDelete(perform: deleteItems)
        }
    }
}

struct ExpenseSection_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseSectionView(title: "Example", expenses: [ExpenseItem(id: UUID(), name: "Lunch", type: "Business", amount: 2_000)], deleteItems: { _ in })
    }
}
