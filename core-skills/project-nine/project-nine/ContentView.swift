//
//  ContentView.swift
//  project-nine
//
//  Created by Ashkan Ebtekari on 8/20/22.
//

import SwiftUI


struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expenses.items, id: \.id) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.price, format: .currency(code: "USD"))
                        }
                    }
                    .onDelete(perform: delete_item)
                }
            }
            .navigationTitle("Expense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    func delete_item(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
