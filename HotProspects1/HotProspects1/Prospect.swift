//
//  Prospect.swift
//  HotProspects1
//
//  Created by David Evans on 12/5/2022.
//

import SwiftUI


@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    private let saveKey = "SavedData"
    private let saveDirectory = "HotProspects.json"

//    init() {
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }
//
//        self.people = []
//    }
    
    init() {
        // BETTER to move this whole thing into an attribute - make saveKey a URL
        let readPath = FileManager.documentsDirectory.appendingPathComponent(saveDirectory)
        
        if FileManager.default.fileExists(atPath: readPath.relativePath) {
            do {
                let data = try Data(contentsOf: readPath)   // TODO: be consistent in error handling
                if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                    people = decoded
                    return
                }
            } catch {
                print("Unable to read data.")
            }
        }
        
        self.people = []
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        saveToDocuments()
//        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func saveToDocuments() {
        let savePath = FileManager.documentsDirectory.appendingPathComponent(saveDirectory)
        do {
            let encoded = try JSONEncoder().encode(people)
            try encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()             // NOTE it is call WILL change, therefore do before changing
        prospect.isContacted.toggle()
        saveToDocuments()
//        save()
    }
}


class Prospect: Identifiable, Codable {

    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false // it can only be changed from within this file - especially since calling objectWillChange on it
    var dateAdded: Date = Date.now
    
    static func sortByDate (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.dateAdded < rhs.dateAdded
    }

    static func sortByName (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }

}



