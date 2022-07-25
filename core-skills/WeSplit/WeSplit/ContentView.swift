//
//  ContentView.swift
//  WeSplit
//
//  Created by Ashkan Ebtekari on 7/24/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tap_count = 0
    @State private var username = ""
    
    private let members = ["Ashkan", "John", "Spencer", "Sparky"]
    @State private var selected_member = "Ashkan"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Hi Ashkan !")
                }
                Section {
                    Group {
                        Text("Hit The Button To Level Up !")
                        Button("Increase Count") {
                            tap_count += 1
                        }
                        Button("Decrease Count") {
                            tap_count -= 1
                        }
                        Text("Your Number is \(tap_count)")
                    }
                }
                Section {
                    Group {
                        Text("Hey Ashkan !")
                        TextField("Please Enter Your Username:", text: $username)
                    }
                }
                if username.isEmpty {
                    Section {
                        Text("Username is Unavailable")
                    }
                } else {
                    Section {
                        Text("Your Username is \(username)")
                    }
                }
                Picker("Select Your Member", selection: $selected_member) {
                    ForEach(members, id: \.self) {
                        Text($0)
                    }
                }
                ForEach(0..<100) {
                    Text("Row Number \($0)")
                }
            }
            .navigationTitle("Welcome Back Ashkan !")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

