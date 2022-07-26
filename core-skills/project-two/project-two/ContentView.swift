//
//  ContentView.swift
//  project-two
//
//  Created by Ashkan Ebtekari on 7/25/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var check_amount = 0.0
    @State private var people_count = 2
    @State private var tip_percentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tip_percentages = [10, 15, 20, 25, 0]
    
    
    var total_per_person: Double {
        let people_number = Double(people_count + 2)
        let tip_selection = Double(tip_percentage)
        
        let tip_value = check_amount / 100 * tip_selection
        let grand_total = check_amount + tip_value
        let amount_per_person = grand_total / people_number
        
        return amount_per_person
    }
    
    var total_price: Double {
        let grand_tip_selection = Double(tip_percentage)
        let grand_tip_value = check_amount / 100 * grand_tip_selection
        let grand_total = check_amount + grand_tip_value
        
        return grand_total
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Group {
                        Text("What's The Amount ?")
                        TextField("Amount", value: $check_amount, format:
                                .currency(code: Locale.current.currencyCode ?? "USD"))
                                .keyboardType(.decimalPad)
                                .focused($amountIsFocused)
                        Picker("Select Number of Members", selection: $people_count) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                    }
                }
                Section {
                    Group {
                        Picker("Select Your Percentage", selection: $tip_percentage) {
                            ForEach(tip_percentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                } header: {
                    Text("Define The Tip Amount")
                }
                Section {
                    Group {
                        Text(total_per_person, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    }
                } header: {
                    Text("Amount Per Person")
                }
                Section {
                    Group {
                        Text(total_price, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    }
                } header: {
                    Text("Total")
                }
                .navigationTitle("Welcome Back !")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            amountIsFocused =  false
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
