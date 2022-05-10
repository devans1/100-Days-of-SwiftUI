//
//  DetailContactView.swift
//  Contacts
//
//  Created by David Evans on 9/5/2022.
//

import SwiftUI

struct ContactDetailView: View {
    
    var name: String
    var image: Image?
    
    var body: some View {
        
        VStack {

            Text(name)
                .font(.title)
                .fontWeight(.bold)
                .padding([.bottom, .top])
            image?
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding([.leading, .trailing])
            Spacer()
        }
    }
    
}

struct DetailContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailView(name: "Fred", image: Image(systemName: "face.smiling"))
    }
}
