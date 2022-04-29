//
//  DataController.swift
//
//  Created by David Evans on 22/4/2022.
//

import CoreData
import Foundation


class DataController: ObservableObject {

    // TODO: UPDATE the NAME in below line
    let container = NSPersistentContainer(name: "Friends")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy=NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}

