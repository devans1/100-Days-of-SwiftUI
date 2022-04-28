//
//  UserLabelView.swift
//  Friends
//
//  Created by David Evans on 28/4/2022.
//

import SwiftUI

struct UserLabelView: View {
    let user: User
    var active: String {
        get {
            user.isActive ? "active" : "inactive"
        }
        
    }
//    let image: Image = Image(systemName: "circle")
//        .foregroundColor(.green)

    
    var body: some View {
        
        HStack {
//            Label("\(user.name)", systemImage: "circle.fill")
//                .frame(maxWidth: .infinity, alignment: .leading)
                Label {
                Text("\(user.name)")
            } icon: {
                Circle()
                    .fill()
                    .foregroundColor(user.isActive ? .green : .red)
                    .frame(width: 15, height: 15, alignment: .leading) // how to make this dynamic - make it a font symbol and size with the font
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        
        UserLabelView(user: User.example)
    }
}
