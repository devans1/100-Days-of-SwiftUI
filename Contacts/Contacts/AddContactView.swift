//
//  AddContactView.swift
//  Contacts
//
//  Created by David Evans on 9/5/2022.
//

import SwiftUI
import CoreLocation

struct AddContactView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: ContentView.ViewModel
    
    @State private var name = ""
    @State private var location = CLLocationCoordinate2D(latitude: .zero, longitude: .zero)

    private var canSave: Bool {
        !name.isEmpty
    }
            
    var body: some View {
        
        NavigationView {
            VStack{
                TextField("Contact Name", text: $name)
                    .padding(.leading)
                    .font(.title)
            
                viewModel.image?
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: .infinity)

            }
//            .navigationTitle("Save contact")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        location = viewModel.locationFetcher.lastKnownLocation ?? CLLocationCoordinate2D(latitude: .zero, longitude: .zero)
                    }, label: {
                        Image(systemName: "location.magnifyingglass")
                    })
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        if canSave {
                            viewModel.saveContactToCD(name: name, location: location)
                            dismiss()
                        }
                    }
                    .foregroundColor(canSave ? .accentColor : .secondary)
                }
            }
        }
    }
}
    

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(viewModel: ContentView.ViewModel())
    }
}
