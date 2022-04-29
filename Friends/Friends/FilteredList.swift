//
//  FilteredList.swift
//
//  Created by David Evans on 26/4/2022.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    enum PredicateType: String {
        case beginsWith = "BEGINSWITH",
             contains = "CONTAINS"
        
    }
    
    let content: (T) -> Content  // one
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String,
         filterValue: String,
         filterPredicate: PredicateType,
         sortDescriptors: [SortDescriptor<T>],
         @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors,
                                        predicate: NSPredicate(format: "%K \(filterPredicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
