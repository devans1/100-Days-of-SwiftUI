//
//  DetailContactView.swift
//  Contacts
//
//  Created by David Evans on 9/5/2022.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContactDetailView: View {
    
    var contact: Contact
    var image: Image?
    var location = CLLocationCoordinate2D(latitude: .zero, longitude: .zero)
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: .zero, longitude: .zero), latitudinalMeters: 750, longitudinalMeters: 750)
    
    var body: some View {
        
        VStack {
            
            Text(contact.wrappedName)
                .font(.title)
                .fontWeight(.bold)
                .padding([.bottom, .top])
            image?
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding([.leading, .trailing])
            if location != CLLocationCoordinate2D(latitude: .zero, longitude: .zero) {
                Map(coordinateRegion: $region,
                    annotationItems: [contact]) { contact in
                    MapMarker(coordinate: contact.coordinate,
                              tint: Color.purple)
                }
            }
            Spacer()
        }
        .onAppear {
            region = MKCoordinateRegion(center: location, latitudinalMeters: 750, longitudinalMeters: 750)
        }
    }
    
}

struct DetailContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailView(contact: Contact.example,
                          image: Image(systemName: "face.smiling"))
    }
}
