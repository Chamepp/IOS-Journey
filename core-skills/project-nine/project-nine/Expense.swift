//
//  Expense.swift
//  project-nine
//
//  Created by Ashkan Ebtekari on 8/20/22.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let saved_items = UserDefaults.standard.data(forKey: "Items") {
            if let decoded_items = try? JSONDecoder().decode([ExpenseItem].self, from: saved_items) {
                items = decoded_items
                return
            }
        }
        items = []
    }
}
