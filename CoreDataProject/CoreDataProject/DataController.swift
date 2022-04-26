//
//  DataController.swift
//  CoreDataProject
//
//  Created by David Evans on 26/4/2022.
//

import Foundation
import CoreData


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

