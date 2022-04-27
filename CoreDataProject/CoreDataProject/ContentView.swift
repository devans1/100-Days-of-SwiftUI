//
//  ContentView.swift
//  CoreDataProject
//
//  Created by David Evans on 26/4/2022.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: [],
////                  predicate: NSPredicate(format: "universe == 'Star Wars'")) var ships: FetchedResults<Ship>
////                  predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
////                  predicate: NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])) var ships: FetchedResults<Ship>
////                  predicate: NSPredicate(format: "name BEGINSWITH %@", "E")) var ships: FetchedResults<Ship>
////                  predicate: NSPredicate(format: "name BEGINSWITH[c] %@", "e")) var ships:  FetchedResults<Ship>        // case insensitive
////                  predicate: NSPredicate(format: "name CONTAINS[c] %@", "f")) var ships:  FetchedResults<Ship>        // case insensitive
//                  predicate: NSPredicate(format: "NOT name CONTAINS[c] %@", "f")) var ships:  FetchedResults<Ship>        // case insensitive, NOT
//    // FYI there is a compound predicate for building up predicates
    
    @State private var lastNameFilter = ""
    @State private var sortDescriptors = [SortDescriptor<Singer>]()
    
    // Candy
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>

    var body: some View {
        
//        VStack {
//                    List(ships, id: \.self) { ship in
//                        Text(ship.name ?? "Unknown name")
//                    }
//
//                    Button("Add Examples") {
//                        let ship1 = Ship(context: moc)
//                        ship1.name = "Enterprise"
//                        ship1.universe = "Star Trek"
//
//                        let ship2 = Ship(context: moc)
//                        ship2.name = "Defiant"
//                        ship2.universe = "Star Trek"
//
//                        let ship3 = Ship(context: moc)
//                        ship3.name = "Millennium Falcon"
//                        ship3.universe = "Star Wars"
//
//                        let ship4 = Ship(context: moc)
//                        ship4.name = "Executor"
//                        ship4.universe = "Star Wars"
//
//                        try? moc.save()
//                    }
//                }
        // Singer
        VStack {
            FilteredList(filterKey: "lastName",
                         filterValue: lastNameFilter,
                         filterPredicate: .beginsWith,
                         sortDescriptors: sortDescriptors) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? moc.save()
            }

            Button("Show A") {
                lastNameFilter = "A"
            }

            Button("Show S") {
                lastNameFilter = "S"
            }
            Button("Sort A-Z") {
                sortDescriptors = [SortDescriptor(\.firstName)]
            }

            Button("Sort Z-A") {
                sortDescriptors = [SortDescriptor(\.firstName, order: .reverse)]
            }
        }
//        VStack {
//            List {
//                ForEach(countries, id: \.self) { country in
//                    Section(country.wrappedFullName) {
//                        ForEach(country.candyArray, id: \.self) { candy in
//                            Text(candy.wrappedName)
//                        }
//                    }
//                }
//            }
//
//            Button("Add") {
//                let candy1 = Candy(context: moc)
//                candy1.name = "Mars"
//                candy1.origin = Country(context: moc)
//                candy1.origin?.shortName = "UK"
//                candy1.origin?.fullName = "United Kingdom"
//
//                let candy2 = Candy(context: moc)
//                candy2.name = "KitKat"
//                candy2.origin = Country(context: moc)
//                candy2.origin?.shortName = "UK"
//                candy2.origin?.fullName = "United Kingdom"
//
//                let candy3 = Candy(context: moc)
//                candy3.name = "Twix"
//                candy3.origin = Country(context: moc)
//                candy3.origin?.shortName = "UK"
//                candy3.origin?.fullName = "United Kingdom"
//
//                let candy4 = Candy(context: moc)
//                candy4.name = "Toblerone"
//                candy4.origin = Country(context: moc)
//                candy4.origin?.shortName = "CH"
//                candy4.origin?.fullName = "Switzerland"
//
//                try? moc.save()
//            }
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
