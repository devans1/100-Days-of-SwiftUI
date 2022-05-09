//
//  ContactsApp.swift
//  Contacts
//
//  Created by David Evans on 9/5/2022.
//

import SwiftUI

@main
struct ContactsApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
