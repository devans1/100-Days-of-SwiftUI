//
//  ContentView-ViewModel.swift
//  Contacts
//
//  Created by David Evans on 9/5/2022.
//

import SwiftUI
import CoreData
import CoreLocation

extension ContentView {

    @MainActor class ViewModel: ObservableObject {
        
        var moc: NSManagedObjectContext? = nil
        let locationFetcher = LocationFetcher()

        @Published var contacts: FetchedResults<Contact>? = nil
        @Published var contactImages = [String: Image]()

        @Published var showingAddScreen = false
        @Published var showingPicker = false
        
        @Published var inputImage: UIImage?
        @Published var image: Image?
        @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
                
        
        func imagePickerDismiss() {
            // convert to Image
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)

            showingAddScreen.toggle()
        }

        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }

        func saveContactToCD(name: String, location: CLLocationCoordinate2D) {
            guard let moc = moc else {
                return
            }

            let contact = Contact(context: moc)
            contact.id = UUID()
            contact.name = name
            contact.photo = ""
            contact.coordinate = location
            
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch {
                    print("Error saving to CoreData - \(error.localizedDescription)")
                }
            }
            
            saveContactToDisk(contact: contact)
        }
        
        func saveContactToDisk(contact: Contact) {
            let savePath = FileManager.documentsDirectory.appendingPathComponent(contact.wrappedFileName)
            do {
                if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
                    try jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])

                    // add to the list of images
                    contactImages[contact.wrappedID] = image
                }
            } catch {
                print("Unable to save data.")
            }
            
        }

        func loadImagesFromDisk()  {
            
            // Check if loaded already
            contacts?.forEach { contact in

                if contactImages[contact.wrappedID] == nil {
                    let readPath = FileManager.documentsDirectory.appendingPathComponent(contact.wrappedFileName).relativePath
                    
                    if FileManager.default.fileExists(atPath: readPath) {
                        if let inputImage = UIImage(contentsOfFile: readPath) {
                            contactImages[contact.wrappedID] = Image(uiImage: inputImage)
                        }
                    }
                }
            }
        }

        func deleteContact(at offsets: IndexSet) {
            for offset in offsets {
                // find this contact in the fetch request
                guard let contact = contacts?[offset] else { return }
                
                // delete it from Core Data
                moc?.delete(contact)
                
                // delete the file
                let readPath = FileManager.documentsDirectory.appendingPathComponent(contact.wrappedFileName).relativePath
                if FileManager.default.fileExists(atPath: readPath) {
                    try? FileManager.default.removeItem(atPath: readPath)
                }
            }
            
            // save to CoreData
            try? moc?.save()
        }
    }

    
}
