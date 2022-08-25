//
//  ContentView.swift
//  project-five
//
//  Created by Ashkan Ebtekari on 7/31/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var items = ["scissors", "rock", "paper"].shuffled()
    @State private var bot_selected = Int.random(in: 0...2)
    @State private var user_selected = 0
    @State private var user_item_title = "?"
    @State private var bot_item_title = "?"
    @State private var score = 0
    @State private var high_score = 0
    @State private var round = 0
    
    @State private var resultIsWin = false
    @State private var resultIsLoss = false
    @State private var resultIsTie = false
    @State private var gameIsDone = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack {
                        Text("Rock, Paper, Scissors")
                            .font(.system(size: 30).weight(.heavy))
                        Text("Round \(round)")
                            .font(.system(size: 20).weight(.bold))
                            .padding(.top, 4)
                }
                .padding(.top, 60)
                
                VStack {
                    Text(user_item_title)
                        .font(.system(size: 50).weight(.black))
                    Text("Please Select Your Item")
                        .font(.system(size: 20).weight(.light))
                    HStack(spacing: 40) {
                        ForEach(0..<3) { number in
                            Button {
                                user_selected = number
                                user_selected_item(user_selected)
                                bot_selected_item(bot_selected)
                            } label: {
                                Image(items[number])
                                    .resizable()
                                    .frame(width: 60, height: 60, alignment: .center)
                            }
                        }
                    }
                    .padding(.top, 40)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 150)
                .background(.secondary)
                .clipShape(Circle())
                .padding(25)
                
                VStack {
                    Button {
                        check_result()
                    } label: {
                        Text("Go !")
                            .font(.system(size: 20).weight(.heavy))
                    }
                    .frame(width: 70, height: 70)
                    .background(.thinMaterial)
                    .cornerRadius(50)
                    .padding(.bottom, 50)
                }
                
                VStack {
                    Text("Score: \(score)")
                        .font(.system(size: 30, weight: .bold, design: .monospaced))
                    Text("High Score: \(high_score)")
                        .font(.system(size: 15, weight: .semibold, design: .monospaced))
                }
                .padding(.bottom, 150)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [.cyan, .mint]), startPoint: .top, endPoint: .bottom))
        }
        .alert("You Won !", isPresented: $resultIsWin) {
            Button("Next Round", action: new_round)
        } message: {
            Text("Opponent Have Been Selected \(items[bot_selected])")
        }
        .alert("You Lost !", isPresented: $resultIsLoss) {
            Button("Next Round", action: new_round)
        } message: {
            Text("Opponent Have Been Selected \(items[bot_selected])")
        }
        .alert("Tie !", isPresented: $resultIsTie) {
            Button("Next Round", action: new_round)
        } message: {
            Text("Opponent have Been Selected \(items[bot_selected])")
        }
        .alert("Game Done", isPresented: $gameIsDone) {
            Button("New Game", action: reset_game)
        } message: {
            Text("Your Score: \(score)")
        }
    }
    
    func user_selected_item(_ number: Int) {
        if number == 0 {
            user_item_title = items[number]
        } else if number == 1 {
            user_item_title = items[number]
        } else {
            user_item_title = items[number]
        }
    }
    
    func bot_selected_item(_ number: Int) {
        if number == 0 {
            bot_item_title = items[number]
        } else if number == 1 {
            bot_item_title = items[number]
        } else {
            bot_item_title = items[number]
        }
    }
    
    func check_result() {
        switch(user_item_title, bot_item_title) {
        // Paper
        case("paper", "paper"):
            print("Tie !")
            resultIsTie = true
        case("paper", "rock"):
            print("You Won !")
            resultIsWin = true
            score += 1
        case("paper", "scissors"):
            print("You Lost !")
            resultIsLoss = true
            score -= 1
            
        // Rock
        case("rock", "rock"):
            print("Tie !")
            resultIsTie = true
        case("rock", "paper"):
            print("You Lost !")
            resultIsLoss = true
            score -= 1
        case("rock", "scissors"):
            print("You Won !")
            resultIsWin = true
            score += 1
            
        // Scissors
        case("scissors", "scissors"):
            print("Tie !")
            resultIsTie = true
        case("scissors", "rock"):
            print("You Lost !")
            resultIsLoss = true
            score -= 1
        case("scissors", "paper"):
            print("You Won !")
            resultIsWin = true
            score += 1
            
        default:
            print("No Result !")
        }
    }
    
    func new_round() {
        round += 1
        resultIsWin = false
        resultIsLoss = false
        resultIsTie = false
        user_item_title = "?"
        bot_item_title = "?"
        
        items.shuffle()
        
        if round >= 10 {
            gameIsDone = true
        }
        
        if score > high_score {
            high_score = score
        }
    }
    func reset_game() {
        score = 0
        round = 0
        gameIsDone = false
        
        new_round()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
