//
//  ContentView.swift
//  project-ten
//
//  Created by Ashkan Ebtekari on 8/22/22.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var showNewGame = false
    @State private var showScores = false
    @State private var showAbout = false
    @State private var startedNewGame = false
    @State private var gameIsDone = false
    
    @FocusState private var keyboardIsFocused: Bool
    
    @State private var score = 0
    @State private var high_score = 0
    @State private var round = 1
    
    
    
    @State private var round_selected = 10
    @State private var first_number = Int.random(in: 1...12)
    @State private var second_number = Int.random(in: 1...12)
    @State private var answer = 0
    
    @State private var alert_title = ""
    @State private var alert_message = ""
    @State private var showAlert = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Multigame")
                        .font(.system(size: 60, weight: .heavy, design: .rounded))
                    HStack(spacing: 60) {
                        if startedNewGame == true {
                            Text("Score : \(score)")
                                .font(.system(size: 22, weight: .light, design: .monospaced))
                            Text("Round: \(round)")
                                .font(.system(size: 22, weight: .light, design: .monospaced))
                        }
                    }
                    if startedNewGame == true {
                        VStack {
                            Text("\(first_number) X \(second_number)")
                                .font(.system(size: 60, weight: .heavy))
                                .padding(.vertical, 50)
                        }
                        HStack(spacing: 40) {
                            TextField("", value: $answer, format: .number)
                                .frame(maxWidth: 100)
                                .multilineTextAlignment(.center)
                                .labelsHidden()
                                .font(.system(size: 50, weight: .thin, design: .monospaced))
                                .disableAutocorrection(true)
                                .keyboardType(.decimalPad)
                                .focused($keyboardIsFocused)
                            Button {
                                ask_question()
                            } label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50, alignment: .center)
                            }
                        }
                    } else {
                        withAnimation {
                            Image(systemName: "square.stack.3d.down.right.fill")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding(.vertical, 50)
                        }
                    }
                }
                Spacer()
                HStack(alignment: .top) {
                    Button {
                        showNewGame = true
                        startedNewGame.toggle()
                    } label: {
                        VStack(alignment: .leading) {
                            Text("Start a New Game")
                                .font(.system(size: 30, weight: .heavy))
                            Text("Start with new multiple tables")
                                .font(.system(size: 20, weight: .light))
                        }
                        .padding(.horizontal, 30)
                        Spacer()
                        Image(systemName: "play")
                            .resizable()
                            .frame(width: 35, height: 35, alignment: .center)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                    }
                }
                HStack(alignment: .top) {
                    Button {
                        showScores = true
                    } label: {
                        VStack(alignment: .leading) {
                            Text("Scores")
                                .font(.system(size: 30, weight: .heavy))
                            Text("See Your Score History")
                                .font(.system(size: 20, weight: .light))
                        }
                        .padding(.horizontal, 30)
                        Spacer()
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 35, height: 35, alignment: .center)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                    }
                }
                HStack(alignment: .top) {
                    Button {
                        showAbout = true
                    } label: {
                        VStack(alignment: .leading) {
                            Text("About")
                                .font(.system(size: 30, weight: .heavy))
                            Text("Read about the program")
                                .font(.system(size: 20, weight: .light))
                        }
                        .padding(.horizontal, 30)
                        Spacer()
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 35, height: 35, alignment: .center)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                    }
                }
                Spacer()
            }
            .alert(alert_title, isPresented: $showAlert) {
                Button("Ok") {
                    showAlert = false
                }
            } message: {
                Text(alert_message)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .foregroundColor(.white)
            .background(
                LinearGradient(gradient: Gradient(colors: [.cyan, .indigo]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
            )
        }
        .navigationTitle("Education")
    }
    func ask_question() {
        let correct_answer = first_number * second_number
        if answer == correct_answer {
            alert_title = "Correct !"
            alert_message = "Your multiplication was correct"
            score += 1
            showAlert = true
        } else {
            alert_title = "Wrong !"
            alert_message = "Your multiplication was wrong"
            score -= 1
            showAlert = true
        }
        first_number = Int.random(in: 1...12)
        second_number = Int.random(in: 1...12)
        round += 1
        keyboardIsFocused = false
        answer = 0
        
        if round == round_selected {
            alert_title = "Finished!"
            alert_message = """
                            Game is done
                            Score: \(score)
                            """
            showAlert = true
            startedNewGame = false
            gameIsDone = true
            round = 1
            score = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
