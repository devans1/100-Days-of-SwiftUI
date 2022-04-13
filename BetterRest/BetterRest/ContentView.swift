//
//  ContentView.swift
//  BetterRest
//
//  Created by David Evans on 14/4/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now

    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours",
                    value: $sleepAmount,
                    in: 4...12,
                    step: 0.25)
            
            DatePicker("Please enter a date",
                       selection: $wakeUp,
                       in: .now...,
                       displayedComponents: .date)
//                .labelsHidden()
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))
            Text(Date.now.formatted(date: .long, time: .omitted))
        }
    }
    
    func exampleDates() {
        // create a second Date instance set to one day in seconds from now
        let tomorrow = Date.now.addingTimeInterval(86400)

        // create a range from those two
        _ = Date.now...tomorrow
        
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        _ = Calendar.current.date(from: components) ?? Date.now
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
