//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by David Evans on 3/5/2022.
//

import MapKit
import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {   // MainActor runs all UI stuff, all this code will also run on the MainActor unless we explicitly tell it otherwise
    }
}
