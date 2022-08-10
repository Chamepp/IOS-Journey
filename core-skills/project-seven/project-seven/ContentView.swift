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
    
    @State private var error_title = ""
    @State private var error_message = ""
    @State private var showing_error = false
    
    var body: some View {
        NavigationView {
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
            .navigationTitle(root_word)
            .onSubmit(add_new_word)
            .onAppear(perform: start_game)
            .alert(error_title, isPresented: $showing_error) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text(error_message)
            }
        }
    }
    func add_new_word() {
        let answer = new_word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            word_error(title: "Word have already been used", message: "Select a more original word")
            return
        }
        guard isPossible(word: answer) else {
            word_error(title: "Word is not possible", message: "You cant spell that word from \(root_word)!")
            return
        }
        guard isReal(word: answer) else {
            word_error(title: "Word not recognized", message: "You can just make it up!")
            return
        }
        
        withAnimation {
            used_words.insert(answer, at: 0)
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
