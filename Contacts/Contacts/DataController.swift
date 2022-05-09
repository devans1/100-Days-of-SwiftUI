//
//  DataController.swift
//  Bookworm
//
//  Created by David Evans on 22/4/2022.
//

import Foundation
import CoreData


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Contacts")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        self.container.viewContext.mergePolicy=NSMergePolicy.mergeByPropertyObjectTrump
    }
}

