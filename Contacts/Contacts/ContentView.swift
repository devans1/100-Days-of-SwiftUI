//
//  ContentView.swift
//  Contacts
//
//  Created by David Evans on 9/5/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var contacts: FetchedResults<Contact>

    @StateObject var viewModel: ViewModel
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(contacts, id: \.self) {contact in
                    NavigationLink {
                        ContactDetailView(contact: contact,
                                          image: viewModel.contactImages[contact.wrappedID],
                                          location: contact.coordinate)
                    } label: {
                        HStack {
                            viewModel.contactImages[contact.wrappedID]?
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40.0)

                            Text(contact.wrappedName)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteContact)
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showingPicker.toggle()
                        viewModel.sourceType = .photoLibrary
                    } label: {
                        Label("Add Contact", systemImage: "photo.on.rectangle.angled")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showingPicker.toggle()
                        viewModel.sourceType = .camera
                    } label: {
                        Label("Add Contact", systemImage: "camera")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingPicker, onDismiss: viewModel.imagePickerDismiss) {
                UIImagePicker(image: $viewModel.inputImage,
                              sourceType: viewModel.sourceType)
            }
            .sheet(isPresented: $viewModel.showingAddScreen) {
                AddContactView(viewModel: viewModel)
            }
            .onAppear() {
                // TODO: this is not good, is there a better way
                viewModel.moc = moc
                viewModel.contacts = contacts
                viewModel.loadImagesFromDisk()
                viewModel.locationFetcher.start()
            }


        }
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
