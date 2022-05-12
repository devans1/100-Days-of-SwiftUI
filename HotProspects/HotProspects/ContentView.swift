//
//  ContentView.swift
//  HotProspects
//
//  Created by David Evans on 12/5/2022.
//

import SamplePackage
import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
//    @Published var value = 0
    var value = 0 {
        willSet {
            print(value, newValue)
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

@MainActor class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
    @StateObject var user: User
    
    @State private var selectedTab: String = "Random"

    @ObservedObject var updater = DelayedUpdater()
    
    @State private var output = ""
    
    @State private var backgroundColor = Color.red

    let possibleNumbers = Array(1...60)
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var test: Int {
        print("hmmm")
        return possibleNumbers.randomElement() ?? 0
    }

    var body: some View {

        VStack {
            //            EditView().environmentObject(user)
            //            DisplayView().environmentObject(user)
            //            DisplayView()
            //            EditView()
            TabView(selection: $selectedTab) {

                VStack {
                    Text(results)
                }
                .tabItem({
                    Label("Random", systemImage: "sun.min")
                })
                .tag("Random")

                VStack {
                    Text("\(test)")
                    List {
                        Text("Taylor Swift")
                            .swipeActions {
                                Button(role: .destructive) {
                                    print("Delete")
                                } label: {
                                    Label("Delete", systemImage: "minus.circle")
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    print("Pin")
                                } label: {
                                    Label("Pin", systemImage: "pin")
                                }
                                .tint(.orange)
                            }
                    }
                }
                .tabItem({
                    Label("Swipe", systemImage: "swift")
                })
                .tag("Swift")
                
                VStack {
                    Text("Hello, World!")
                        .padding()
                        .background(backgroundColor)
                    
                    Text("Change Color")
                        .padding()
                        .contextMenu {
                            Button(role: .destructive,
                                   action: { backgroundColor = .red },
                                   label: { Label("Red", systemImage: "checkmark.circle.fill") }
                            )
//                            Button("Red") {
//                                backgroundColor = .red
//                            }
                            
                            Button("Green") {
                                backgroundColor = .green
                            }
                            
                            Button("Blue") {
                                backgroundColor = .blue
                            }
                        }
                }
                .tabItem {
                    Label("Three", systemImage: "cloud")
                }
                .tag("Three")
                .onAppear {
                    print("three")
                }

                VStack {
                    Text("Tab 2")
                    Image("example")
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: .infinity)
                        .background(.black)
                        .ignoresSafeArea()
                }
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
                .onAppear {
                    print("two")
                }

                VStack {
                    Text(output)
                        .task {
                            await fetchReadings()
                        }
                    Text("Value is: \(updater.value)")
                }
                .tabItem {
                    Label("Updater", systemImage: "star")
                }
                .tag("Updater")
                .onAppear {
                    print("updater")
                }

            }
        }
        .environmentObject(user)
    }
    
    init() {
        _user = StateObject(wrappedValue: User() )
    }
    
//    func fetchReadings() async {
//        do {
//            let url = URL(string: "https://hws.dev/readings.json")!
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let readings = try JSONDecoder().decode([Double].self, from: data)
//            output = "Found \(readings.count) readings"
//        } catch {
//            print("Download error")
//        }
//    }

    func fetchReadings() async {
        
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        
        switch result {
            case .success(let str):
                output = str
            case .failure(let error):
                output = "Error: \(error.localizedDescription)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
