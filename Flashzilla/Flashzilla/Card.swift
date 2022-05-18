//
//  Card.swift
//  Flashzilla
//
//  Created by David Evans on 16/5/2022.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    var id: UUID

    let prompt: String
    let answer: String

    static let example = Card(id: UUID(),
                              prompt: "Who played the 13th Doctor in Doctor Who?",
                              answer: "Jodie Whittaker")
}

@MainActor class Cards: ObservableObject {
    @Published private(set) var cards: [Card]

    private let savePath = FileManager.documentsDirectory.appendingPathComponent("Flashzilla.json")

    init() {
        self.cards = []
        loadData()
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: savePath)
            let decoded = try JSONDecoder().decode([Card].self, from: data)
            self.cards = decoded
            return
        } catch {
            print("Loading failed with error \(error.localizedDescription)")
        }        
    }
    
    private func save() {
        do {
            let encoded = try JSONEncoder().encode(cards)
            try encoded.write(to: savePath)
        } catch {
            print("Saving failed with \(error.localizedDescription)")
        }
    }
    
    func add(prompt: String, answer: String) -> Void {
        let trimmedPrompt = prompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(id: UUID(), prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        save()
    }

    func remove(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        save()
    }

    func move(from: Int) {
        cards.move(fromOffsets: IndexSet(integer: from), toOffset: 0)
    }
    
    func moveOff(at index: Int) {
        cards.remove(at: index)
    }
    
}
