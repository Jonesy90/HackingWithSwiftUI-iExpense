//
//  ContentView.swift
//  HackingWithSwiftUI-iExpense
//
//  Created by Michael Jones on 14/06/2026.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<ExpenseItem> { $0.type == "Personal" }) var personalExpenses: [ExpenseItem]
    @Query(filter: #Predicate<ExpenseItem> { $0.type == "Business" }) var businessExpenses: [ExpenseItem]
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ExpenseSection(title: "Personal", expenses: personalExpenses, deleteItems: removePersonalItems)
                ExpenseSection(title: "Business", expenses: businessExpenses, deleteItems: removeBusinessItems)
            }
            .navigationTitle("iExpense")
            .navigationBarBackButtonHidden()
            .toolbar {
                NavigationLink {
                    AddView(expenses: viewModel.allExpenses)
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
    }
    
    private func removePersonalItems(at offsets: IndexSet) {
        viewModel.removeItems(at: offsets, in: personalExpenses, modelContext: modelContext)
    }
    
    private func removeBusinessItems(at offsets: IndexSet) {
        viewModel.removeItems(at: offsets, in: businessExpenses, modelContext: modelContext)
    }
}

#Preview {
    ContentView()
}
