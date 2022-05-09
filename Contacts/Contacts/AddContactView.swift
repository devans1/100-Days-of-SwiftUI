//
//  AddContactView.swift
//  Contacts
//
//  Created by David Evans on 9/5/2022.
//

import SwiftUI

struct AddContactView: View {
    @State private var name = ""
    @State private var photo = ""
        
    var body: some View {
        VStack{
            TextField("Contact Name", text: $name)
            TextField("Photo", text: $photo)
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
