//
//  Mission.swift
//  project-eleven
//
//  Created by Ashkan Ebtekari on 11/10/22.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launch_date: Date?
    let crew: [CrewRole]
    let description: String
    
    var display_name: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formatted_launch_date: String {
        launch_date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
