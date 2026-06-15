//
//  ContentView.swift
//  HackingWithSwiftUI-iExpense
//
//  Created by Michael Jones on 14/06/2026.
//

import SwiftUI

/// This stores all the information needed for a single Expense. With built-in support for unique identification and saving/loading.
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

/// This class manages the list of expenses, automatically saves the expense list whenever it changes and loads previously saved expenses when the app launches (or whenever a new Expense instance is created). This is an Observable, so any SwiftUI views using it will update automatically when the data changes.
@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text(item.amount, format: .currency(code: "GBP"))
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            
        }
    }
    
    //Purpose: Designed to remove one or more items from the 'expenses.item' array at the specified positions.
    //How it works?: The parameter represents a set of indexes that should be removes. With the convenience method (provided in Swift for arrays), it will remove all elements in the array at the indexes specified.
    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
