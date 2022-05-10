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

    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(contacts, id: \.self) {contact in
                    NavigationLink {
                        ContactDetailView(name: contact.wrappedName,
                                          image: viewModel.contactImages[contact.wrappedID])
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
                .onDelete(perform: deleteContact)
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showingPicker.toggle()
                    } label: {
                        Label("Add Contact", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingPicker) {
                UIImagePicker(image: $viewModel.inputImage, sourceType: .photoLibrary)
            }
            .sheet(isPresented: $viewModel.showingAddScreen) {
                AddContactView(inputImage: $viewModel.inputImage, image: $viewModel.image)
            }
            .onChange(of: viewModel.inputImage) { _ in
                viewModel.loadImage()
            }
            .onChange(of: viewModel.showingAddScreen) { _ in
                loadImagesFromDisk()
            }
            .onAppear() {
                loadImagesFromDisk()
            }


        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
