//
//  ContentView.swift
//  project-seven
//
//  Created by Ashkan Ebtekari on 8/9/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var used_words = [String]()
    @State private var root_word = ""
    @State private var new_word = ""
    
    @State private var score = 0
    @State private var high_score = 0
    
    @State private var error_title = ""
    @State private var error_message = ""
    @State private var showing_error = false
    
    @State private var showing_new_word = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text(root_word)
                        .font(.system(size: 45, weight: .regular, design: .rounded))
                    Text("Score: \(score)     Highscore: \(high_score)")
                        .font(.system(size: 20, weight: .light, design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                List {
                    Section {
                        TextField("What's Your Word", text: $new_word)
                            .autocapitalization(.none)
                    }
                    Section {
                        ForEach(used_words, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle.fill")
                                Text(word)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .toolbar {
                    Button {
                        showing_new_word = true
                    } label: {
                        Text("New Word")
                    }
                }
                .onSubmit(add_new_word)
                .onAppear(perform: start_game)
                .alert(error_title, isPresented: $showing_error) {
                    Button("Ok", role: .cancel) {}
                } message: {
                    Text(error_message)
                }
                .alert("New Word", isPresented: $showing_new_word) {
                    Button("Ok", role: .destructive) {
                        start_game()
                        score -= 2
                    }
                    Button("Cancel", role: .cancel, action: start_game)
                } message: {
                    Text("New word costs 2 points")
                }
            }
        }
    }
    func add_new_word() {
        let answer = new_word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard isMore(word: answer) else {
            word_error(title: "Word should be more than two", message: "Select a bigger word")
            return
        }
        guard answer != root_word else {
            word_error(title: "You just repeated the word", message: "Try a diffrent structure")
            return
        }
        guard isOriginal(word: answer) else {
            score -= 1
            word_error(title: "You Losed a Point !", message: "Word have already been used")
            return
        }
        guard isPossible(word: answer) else {
            score -= 1
            word_error(title: "You Losed a Point", message: "Word is not possible")
            return
        }
        guard isReal(word: answer) else {
            score -= 1
            word_error(title: "You Losed a Point", message: "You can't just make it up!")
            return
        }
        
        withAnimation {
            used_words.insert(answer, at: 0)
        }
        
        score += 1
        if score > high_score {
            high_score = score
        }
        new_word = ""
    }
    func start_game() {
        if let start_words_url = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let start_words = try? String(contentsOf: start_words_url) {
                let all_words = start_words.components(separatedBy: "\n")
                root_word = all_words.randomElement() ?? "silkworm"
                
                return
            }
        }
        fatalError("Could'nt load the bundle.")
    }
    func isOriginal(word: String) -> Bool {
        !used_words.contains(word)
    }
    func isPossible(word: String) -> Bool {
        var temp_word = root_word
        
        for letter in word {
            if let pos = temp_word.firstIndex(of: letter) {
                temp_word.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelled_range = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelled_range.location == NSNotFound
    }
    func isMore(word: String) -> Bool {
        if new_word.count > 2 {
            return true
        } else {
            return false
        }
    }
    func word_error(title: String, message: String) {
        error_title = title
        error_message = message
        
        showing_error = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
