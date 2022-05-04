//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by David Evans on 3/5/2022.
//

import Foundation
import MapKit
import LocalAuthentication

extension ContentView {
    @MainActor class ViewModel: ObservableObject {   // MainActor runs all UI stuff, all this code will also run on the MainActor unless we explicitly tell it otherwise
        
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
                                                      span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        //        @Published private(set) var locations = [Location]()
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var bioAuthenticationFailed = false

        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
                
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(),
                                       name: "New location",
                                       description: "",
                                       latitude: mapRegion.center.latitude,
                                       longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    
                    Task { @MainActor in
                        if success {
                            self.isUnlocked = true
                        } else {
                            
                            // error
                            guard let authenticationError = authenticationError else {
                                return
                            }

                            let err = LAError.Code(rawValue: authenticationError._code)!

                            switch err {
                            case LAError.Code.userCancel:
                                self.isUnlocked = false
                            default:
                                self.bioAuthenticationFailed = true
                            }
                            
                            print("Bio Authentication Failed \(authenticationError.localizedDescription)")
                        }
                    }
                }
            } else {
                // no biometrics
                print("No biometrics")
                self.bioAuthenticationFailed = true
            }
        }
            
    }
}
