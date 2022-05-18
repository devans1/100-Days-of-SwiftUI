//
//  EditCards.swift
//  Flashzilla
//
//  Created by David Evans on 17/5/2022.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var deck: Cards

    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card") {
                        deck.add(prompt: newPrompt, answer: newAnswer)
                        newPrompt = ""
                        newAnswer = ""
                    }
                }
                
                Section {
                    ForEach(deck.cards) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: done)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .listStyle(.grouped)
        }
    }
    
    func done() {
        dismiss()
    }
    
    func removeCards(at offsets: IndexSet) {
        deck.remove(at: offsets)
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
