//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by David Evans on 12/4/2022.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 10)
    }
}

//struct FlagView: ViewModifier {
//    func body(content: Content) -> some View {
//        .renderingMode(.original)
//        .clipShape(Capsule())
//        .shadow(radius: 10)
//    }
//}
//
//extension View {
//    func flagStyle() -> View {
//        modifier(FlagView())
//    }
//}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""

    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var countries = allCountries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var guess = 0
    @State private var gameOverTitle = ""
    @State private var gameOver = false
    
    let numberGames = 3
    
    
    
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                Gradient.Stop(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 500)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))

                        Button {
                                // flag was tapped
                                flagTapped(0)
                            } label: {
                                FlagImage(country: countries[0])
                            }

                        ForEach(1..<3) { number in
                            Button {
                                // flag was tapped
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .shadow(radius: 10)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(gameOverTitle, isPresented: $gameOver) {
            Button("New game?", action: newGame)
        } message: {
            if score > numberGames/2 {
                Text("Game over: Your score is \(score) congratulations, that is good")
            } else {
                Text("Game over: Your score is \(score)")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        guess += 1
        if number == correctAnswer {
            scoreTitle = "Correct, that's the flag for \(countries[number])"
            score += 1
            countries.remove(at: number)
        } else {
            scoreTitle = "Wrong, that's the flag for \(countries[number])"
        }

        if guess >= numberGames {
            gameOver = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        print("askQuestion called")
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func newGame() {
        countries = ContentView.allCountries
        askQuestion()
        score = 0
        guess = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
