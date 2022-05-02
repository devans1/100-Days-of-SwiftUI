//
//  ContentView.swift
//  BucketList
//
//  Created by David Evans on 2/5/2022.
//

import LocalAuthentication
import MapKit
import SwiftUI


struct ContentView: View {
    
    @State private var isUnlocked = false
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))

    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")

            } else {
                Text("Locked")

            }
        }
        .onAppear(perform: authenticate)
    }
    
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data." // only used for touch ID, Face ID is in info.plist

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
