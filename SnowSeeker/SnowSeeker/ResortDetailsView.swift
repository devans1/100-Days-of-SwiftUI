//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by David Evans on 23/5/2022.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
// How interesting - I like it :)  Create the array and then index into it!
//    var size: String {
//        ["Small", "Average", "Large"][resort.size - 1]
//    }
    
    var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }

    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        Group {
            VStack {
                Text("Size")
                    .font(.caption.bold())
                Text(size)
                    .font(.title3)
            }
            
            VStack {
                Text("Price")
                    .font(.caption.bold())
                Text(price)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
