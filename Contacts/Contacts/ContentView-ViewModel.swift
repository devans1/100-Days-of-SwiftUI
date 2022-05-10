//
//  ContentView-ViewModel.swift
//  Contacts
//
//  Created by David Evans on 9/5/2022.
//

import SwiftUI

extension ContentView {

    @MainActor class ViewModel: ObservableObject {
        
        @Published var contactImages = [String: Image]()

        @Published var showingAddScreen = false
        @Published var showingPicker = false
        
        @Published var inputImage: UIImage?
        @Published var image: Image?

        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
            showingAddScreen.toggle()
        }
        
    }

    func deleteContact(at offsets: IndexSet) {
        for offset in offsets {
            // find this contact in the fetch request
            let contact = contacts[offset]
            
            // delete it from the CD context
            moc.delete(contact)
            
            // move the file to the trash
            let readPath = FileManager.documentsDirectory.appendingPathComponent(contact.wrappedFileName).relativePath
            if FileManager.default.fileExists(atPath: readPath) {
                try? FileManager.default.removeItem(atPath: readPath)
            }
        }
        
        // save the context
        try? moc.save()
    }
    
    
    func loadImagesFromDisk()  {
        
        // Check if loaded already
         contacts.forEach { contact in

            if viewModel.contactImages[contact.wrappedID] == nil {
                let readPath = FileManager.documentsDirectory.appendingPathComponent(contact.wrappedFileName).relativePath
                
                if FileManager.default.fileExists(atPath: readPath) {
                    if let inputImage = UIImage(contentsOfFile: readPath) {
                        viewModel.contactImages[contact.wrappedID] = Image(uiImage: inputImage)
                    }
                }
            }
        }
    }

}
