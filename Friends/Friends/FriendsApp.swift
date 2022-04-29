//
//  FriendsApp.swift
//  Friends
//
//  Created by David Evans on 27/4/2022.
//

import SwiftUI

@main
struct FriendsApp: App {
    
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
