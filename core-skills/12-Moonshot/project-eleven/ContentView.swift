//
//  ContentView.swift
//  project-eleven
//
//  Created by Ashkan Ebtekari on 11/1/22.
//

import SwiftUI



struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("mission.json")
    
    var body: some View {
        Text("\(astronauts.count)")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
