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
    
//    @State private var contacts = [Contact]()

    @State private var showingAddScreen = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(contacts) {contact in
                    NavigationLink {
                        Text("pick one")
//                        DetailView(book: book)
                    } label: {
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text(contact.name ?? "Unknown name")
                                    .font(.headline)

                                Text(contact.photo ?? "Unknown photo")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Contact", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddContactView()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
