//
//  ExpenseItem.swift
//  project-nine
//
//  Created by Ashkan Ebtekari on 8/20/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let price: Double
}
