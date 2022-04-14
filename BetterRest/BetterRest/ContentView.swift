//
//  ContentView.swift
//  BetterRest
//
//  Created by David Evans on 14/4/2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    static var defaultWakeTime: Date {  // make static, because it can be and because it needs to be available before self init run
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        
                        DatePicker("Please enter a time",
                                   selection: $wakeUp,
                                   displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    }
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                }

                
                Section {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Daily coffee intake")
                            .font(.headline)
                        
                        Picker("Number of cups", selection: $coffeeAmount) {
                            ForEach(1..<21, id: \.self) { i in
                                Text("\(i)")
                            }
                        }
                        // The Stepper is better
//                        Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                    }
                }
//                Section {
//                    VStack(alignment: .leading, spacing: 0) {
//                        Text("Daily coffee intake")
//                            .font(.headline)
//
//                        Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
//                    }
//                }
                Section {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Bedtime is \(calculateBedtime())")
                            .font(.largeTitle)
                    }
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OK") { }
//            } message: {
//                Text(alertMessage)
//            }
        }
    }
    
    // A better way is to make a calculated variable, take all code from calculateBedtime() and put it in here
//    var sleepResults : String {
//
//    }
    
    func calculateBedtime() -> String {
        var bedtime: String = ""
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            print("Coffee cups = \(coffeeAmount)")
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            bedtime = sleepTime.formatted(date: .omitted, time: .shortened)
//            alertTitle = "Your ideal bedtime is…"
            
        } catch {
            // something went wrong!
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime."
            bedtime = "Error"
        }
//        showingAlert = true
        return bedtime
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
