//
//  NewGame.swift
//  project-ten
//
//  Created by Ashkan Ebtekari on 8/23/22.
//

import SwiftUI



struct NewGame: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    @State private var round_selected = 5
    @State private var rounds_amount = [5, 10, 20]
    
    @State private var multiplication_table = 1.0
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("New Game")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.white)
                }
                Form {
                    Section("Rounds") {
                        Picker("Number of Rounds", selection: $round_selected) {
                            ForEach(rounds_amount, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .foregroundColor(.black)
                        .pickerStyle(.segmented)
                    }
                    .foregroundColor(.white)
                    Section("Multiple") {
                        Stepper("Table of \(multiplication_table.formatted())", value: $multiplication_table, in: 1...12, step: 1.0)
                        .foregroundColor(.black)
                    }
                    .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 100)
                .background(.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(25)
                Button {
                    // more to come here
                } label: {
                    VStack(alignment: .leading) {
                        Text("Start")
                            .font(.system(size: 40, weight: .heavy))
                    }
                    .padding(.horizontal, 30)
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                }
                .foregroundColor(.white)
                .padding(.bottom, 100)
            }
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [.cyan, .indigo]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
            )
        }
        .navigationTitle("New Game")
    }
}

struct NewGame_Previews: PreviewProvider {
    static var previews: some View {
        NewGame()
    }
}
