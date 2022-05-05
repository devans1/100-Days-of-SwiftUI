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
    @State private var scoreTitle = "Let's begin"

    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var countries = allCountries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var guessCount = 0
    @State private var gameOverTitle = ""
    @State private var gameOver = false
    
    let numberGames = 5
    
    @State private var flagClickedIndex = -1
    @State private var nextTry = true
    
    var body: some View {
        print("flagClickedIndex:\(flagClickedIndex) ") ; return

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

                        ForEach(0..<3) { number in
                            Button {
                                // flag was tapped
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .shadow(radius: 10)
                                    .rotation3DEffect(.degrees(flagClickedIndex == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                    .opacity(flagClickedIndex == -1 || flagClickedIndex == number ? 1.0 : 0.25)
                                    .scaleEffect(flagClickedIndex == -1 || flagClickedIndex == number ? 1.0 : 0.75)
                                    .animation(.default, value: flagClickedIndex)
                                    .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                            }

                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Text("\(scoreTitle)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: newTry)
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
        print("FlagTapped")
        guessCount += 1
        flagClickedIndex = number

        if number == correctAnswer {
            scoreTitle = "Correct, that's the flag for \(countries[number])"
            score += 1
            countries.remove(at: number)
        } else {
            scoreTitle = "Wrong, that's the flag for \(countries[number])"
        }

        if guessCount >= numberGames {
            gameOver = true
        }
        showingScore = true;
        //        newTry()
    }
    
    func newTry() {
        print("newTry")
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        flagClickedIndex = -1
        showingScore = false
    }
    
    func newGame() {
        countries = ContentView.allCountries
        score = 0
        guessCount = 0
        scoreTitle = "Let's begin"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
