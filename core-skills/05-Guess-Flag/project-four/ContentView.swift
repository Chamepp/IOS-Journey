//
//  ContentView.swift
//  project-four
//
//  Created by Ashkan Ebtekari on 7/27/22.
//

import SwiftUI


struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 40).weight(.heavy))
            .foregroundColor(.white)
    }
}

extension View {
    func main_title() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var showScore = false
    @State private var showGameOver = false
    @State private var showFinalResults = false
    @State private var score_title = ""
    @State private var score = 0
    @State private var user_selected = 0
    @State private var question_count = 0
    @State private var round_count = 1
    @State private var selectedFlag = -1
    
    
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
                    .main_title()
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
                            user_selected = number
                            flag_tapped(user_selected)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .modifier(FlagImage())
                                .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                                .animation(.default, value: selectedFlag)
                                .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                                .saturation(selectedFlag == -1 || selectedFlag == number ? 1 : 0)
                                .blur(radius: selectedFlag == -1 || selectedFlag == number ? 0 : 3)
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
            Text("Wrong! That's \(countries[user_selected])")
        }
        .alert("Your Score: \(score)", isPresented: $showFinalResults) {
            Button("Start a New Round", action: reset_game)
        } message: {
            Text("Round \(round_count) Finished")
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
        selectedFlag = number
        
    }
    
    func ask_question() {
        countries.shuffle()
        correct_answer = Int.random(in: 0...2)
        question_count += 1
        selectedFlag = -1
        
        if question_count >= 8 {
            showFinalResults = true
        }
    }
    
    func reset_game() {
        score = 0
        question_count = 0
        round_count += 1
        
        ask_question()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
