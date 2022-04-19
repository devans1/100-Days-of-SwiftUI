//
//  ContentView.swift
//  iExpense
//
//  Created by David Evans on 19/4/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
        
    var body: some View {
        //        print("\(user.firstName) \(user.lastName)") ; return
        NavigationView {
            List {
                ExpenseSectionView(title: "Business",
                                   expenses: expenses.businessItems,
                                   deleteItems: removeBusinessItems)
                ExpenseSectionView(title: "Personal",
                                   expenses: expenses.personalItems,
                                   deleteItems: removePersonalItems)
            }
            .navigationTitle("iExpense")
            .toolbar(content: {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            })
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
        
    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let item = inputArray[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }
        
        expenses.items.remove(atOffsets: objectsToDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalItems)
    }

    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
