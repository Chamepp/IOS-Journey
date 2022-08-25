//
//  AddView.swift
//  project-nine
//
//  Created by Ashkan Ebtekari on 8/21/22.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var item_name = ""
    @State private var item_type = "Personal"
    @State private var item_amount = 1.0
    @State private var item_price = 0.0
    @State private var error_title = ""
    @State private var error_message = ""
    @State private var showError = false
    
    private enum ItemErrors {
        case MissingName
        case MissingType
        case MissingAmount
    }
    
    @State private var item_types = ["Personal", "Buisiness", "Duel"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Item Name") {
                        TextField("Name", text: $item_name)
                            .autocapitalization(.none)
                    }
                    Section("Item Type") {
                        Picker("Select Type", selection: $item_type) {
                            ForEach(item_types, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                    Section("Item Amount") {
                        Stepper(item_amount == 1 ? "\(item_amount.formatted()) Item" : "\(item_amount.formatted()) Items", value: $item_amount, in: 1...100, step: 1)
                    }
                    Section("Item Price") {
                        TextField("Price", value: $item_price, format: .currency(code: "USD"))
                            .keyboardType(.decimalPad)
                    }
                }
            }
            .navigationTitle("Add New Expense")
            .alert(error_title, isPresented: $showError) {
                
            } message: {
                Text(error_message)
            }
            .toolbar {
                Button {
                    guard item_name != "" else {
                        item_error(title: "Name Missing!", message: "Please enter the item name")
                        return
                    }
                    guard item_name.count > 2 else {
                        item_error(title: "Short Name !", message: "Please select a longer name")
                        return
                    }
                    let expense_item = ExpenseItem(name: item_name, type: item_type, amount: item_amount, price: item_price)
                    expenses.items.append(expense_item)
                    item_error(title: "Done!", message: "The item added successfuly")
                    item_name = ""
                    item_type = "Personal"
                    item_amount = 1
                    item_price = 0.0
                    dismiss()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    func item_error(title: String, message: String) {
        error_title = title
        error_message = message
        
        showError = true
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
