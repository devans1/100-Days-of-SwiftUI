//
//  ContentView.swift
//  Flashzilla
//
//  Created by David Evans on 16/5/2022.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}


struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
//    @State private var cards = [Card](repeating: Card.example, count: 10)
    
    @StateObject var deck = Cards()

    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var showingEditScreen = false
        
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(Array(deck.cards.enumerated()), id: \.element) { item in
                        CardView(card: item.element) { reTry in
                            withAnimation {
                                removeCard(at: item.offset, reTry: reTry)
                            }
                        }
                        .stacked(at: item.offset, in: deck.cards.count)
                        .allowsHitTesting(item.offset == deck.cards.count - 1)  // can only drag the top card
                        .accessibilityHidden(item.offset < deck.cards.count - 1)  // stop voice over announcing all the cards
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                if deck.cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: deck.cards.count - 1, reTry: true)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: deck.cards.count - 1, reTry: false)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .environmentObject(deck)
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if deck.cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen,
               onDismiss: resetCards) {
            EditCards()
                .environmentObject(deck)
        }
//               content: EditCards.init) // another different way to call sheet
        .onAppear(perform: resetCards)
        
    }
    
//    func loadData() {
//        if let data = UserDefaults.standard.data(forKey: "Cards") {
//            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
//                cards = decoded
//            }
//        }
//    }

    
    func removeCard(at index: Int, reTry: Bool) {
        guard index >= 0 else { return }
        
        if reTry {
            deck.move(from: index)
        } else {
            deck.moveOff(at: index)
            
            if deck.cards.isEmpty {
                isActive = false
            }
        }
    }
    
    func resetCards() {
//        cards = [Card](repeating: Card.example, count: 10)
        deck.loadData()
        timeRemaining = 100
        isActive = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
