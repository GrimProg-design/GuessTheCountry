//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Вавилов Илья on 20/1/26.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numberOfAnswer = 0
    @State private var finalMessage = false
    @State private var choice = ""
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Spacer()
                VStack (spacing: 15) {
                    VStack {
                        HStack {
                            Spacer()
                            
                            Text("Tap the flag of")
                                .font(.subheadline.weight(.heavy))
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                        }
                        .overlay(
                            Text("\(numberOfAnswer)/8")
                                .font(.subheadline.weight(.heavy))
                                .foregroundStyle(.secondary)
                                .padding(.trailing),
                            alignment: .trailing
                        )
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            choice = countries[number]
                            if numberOfAnswer == 7 {
                                finish()
                            }
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                
                Text("Your score is \(score)")
                    .font(.title.weight(.heavy))
                    .foregroundStyle(.white)
                
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
                .foregroundStyle(.white)
                .font(.title.bold())
        }
        .alert("Finish!!", isPresented: $finalMessage) {
            Button ("Restart", action: restart)
        } message: {
            Text("Your final score is \(score)")
                .foregroundStyle(.white)
                .font(.title.bold())
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            numberOfAnswer += 1
        } else {
            scoreTitle = "Wrong, this flag is \(choice)"
            numberOfAnswer += 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        if numberOfAnswer < 8 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func finish() {
        finalMessage = true
    }
    
    func restart() {
        numberOfAnswer = 0
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
