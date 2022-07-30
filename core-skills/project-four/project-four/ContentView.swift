//
//  ContentView.swift
//  project-four
//
//  Created by Ashkan Ebtekari on 7/27/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showScore = false
    @State private var showGameOver = false
    @State private var score_title = ""
    @State private var score = 0
    
    @State private var countries = ["Germany", "Estonia", "France", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain"].shuffled()
    @State private var correct_answer = Int.random(in: 0...2)
    
    
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    Gradient.Stop(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.system(size: 40).weight(.heavy))
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap The Flag of")
                            .foregroundColor(.white)
                            .font(.system(size: 20).weight(.heavy))
                            
                        Text(countries[correct_answer])
                            .foregroundColor(.white)
                            .font(.system(size: 30).weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flag_tapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                
                VStack {
                    Text("Your Score is")
                        .font(.system(size: 30).weight(.bold))
                        .foregroundColor(.white)
                    
                    Text("-   \(score)   -")
                        .font(.system(size: 40).weight(.bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
            }
            .padding(25)
        }
        .alert("Great Job", isPresented: $showScore) {
            Button("Continue", action: ask_question)
        } message: {
            Text("The Selected Flag is Correct")
        }
        .alert("Game Over", isPresented: $showGameOver) {
            Button("Continue", action: ask_question)
        } message: {
            Text("Your Score is Back To Zero")
        }
    }
    func flag_tapped(_ number: Int) {
        if number == correct_answer {
            score_title = "Correct"
            score += 1
            showScore = true
        } else {
            score_title = "Wrong"
            score = 0
            showGameOver = true
        }
        
    }
    
    func ask_question() {
        countries.shuffle()
        correct_answer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
