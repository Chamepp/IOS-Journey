//
//  Mission.swift
//  project-eleven
//
//  Created by Ashkan Ebtekari on 11/10/22.
//

import Foundation

struct Mission: Codable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launch_date: String?
    let crew: [CrewRole]
    let description: String
}
