//
//  AddContactView.swift
//  Contacts
//
//  Created by David Evans on 9/5/2022.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    
    @Binding var inputImage: UIImage?
    @Binding var image: Image?

    @State private var name = ""
    
    private var canSave: Bool {
        !name.isEmpty
    }
        
    var body: some View {
        
        NavigationView {
            VStack{
                TextField("Contact Name", text: $name)
                    .padding(.leading)
                    .font(.title)
            
                image?
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
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        if canSave {
                            saveContactToCD(name: name)
                            dismiss()
                        }
                    }
                    .foregroundColor(canSave ? .accentColor : .secondary)
                }
            }
        }
    }
    
    func saveContactToCD(name: String) {
        let contact = Contact(context: moc)
        contact.id = UUID()
        contact.name = name
        contact.photo = ""
        
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
            }
        } catch {
            print("Unable to save data.")
        }
    }

}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(inputImage: .constant(UIImage(systemName: "bell.fill")), image: .constant(Image(systemName: "bell")))
    }
}
