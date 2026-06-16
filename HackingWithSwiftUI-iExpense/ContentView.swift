//
//  ContentView.swift
//  HackingWithSwiftUI-iExpense
//
//  Created by Michael Jones on 14/06/2026.
//

/* Challenges
 1. Use the user’s preferred currency, rather than always using US dollars. - DONE!
 2. Modify the expense amounts in ContentView to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style. What those styles are depend on you. - DONE!
 3. For a bigger challenge, try splitting the expenses list into two sections: one for personal expenses, and one for business expenses. This is tricky for a few reasons, not least because it means being careful about how items are deleted!
*/

import SwiftUI

/// Extension of the View protocol. It adds a custom method that takes an ExpenseItem.
extension View {
    func style(for item: ExpenseItem) -> some View {
        if item.amount < 10 {
            return self.font(.body)
        } else if item.amount < 100 {
            return self.font(.title3)
        } else {
            return self.font(.title)
        }
    }
}

/// This stores all the information needed for a single Expense. With built-in support for unique identification and saving/loading.
struct ExpenseItem: Identifiable, Codable, Equatable {
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
    
    var personalItems: [ExpenseItem] {
        items.filter { $0.type == "Personal" }
    }
    
    var businessItems: [ExpenseItem] {
        items.filter { $0.type == "Business" }
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

struct ExpenseSection: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    /// Gets the current locale settings of the user based on their device settings (region, language etc). Ensures the preferred regional currency is used when showing prices.
    let preferredCurrency = Locale.current.currency?.identifier ?? "GBP"
    
    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                        
                        Spacer()
                        
                        HStack {
                            Text(item.amount, format: .currency(code: preferredCurrency))
                                .foregroundStyle(item.amount <= 10.00 ? Color.green : item.amount > 10.00 && item.amount <= 100.00 ? Color.orange : Color.red)
                                .style(for: item)
                        }
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ExpenseSection(title: "Personal", expenses: expenses.personalItems, deleteItems: removePersonalItems)
                ExpenseSection(title: "Business", expenses: expenses.businessItems, deleteItems: removeBusinessItems)
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
    
    private func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalItems)
    }
    
    private func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }
    
    
    //Purpose: Designed to remove one or more items from the 'expenses.item' array at the specified positions.
    //How it works?: The parameter represents a set of indexes that should be removes. With the convenience method (provided in Swift for arrays), it will remove all elements in the array at the indexes specified.
    private func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let item = inputArray[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }
        
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
